//
//  NewsTagmakerViewController.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/30.
//

import UIKit
import SnapKit
import Toast_Swift

final class NewsTagmakerViewController: UIViewController {
    private var presenter: NewsTagmakerPresenter!
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = presenter
        return searchBar
    }()
    
    private lazy var rightBarButton = UIBarButtonItem(
        image: UIImage(systemName: "plus"),
        style: .plain,
        target: self,
        action: #selector(didTapRightBarButton)
    )
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            NewsTagmakerViewCell.self,
            forCellWithReuseIdentifier: NewsTagmakerViewCell.identifier
        )
        collectionView.dataSource = presenter
        collectionView.delegate = presenter
        return collectionView
    }()
    
    private lazy var adjustButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("적용하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19.0, weight: .semibold)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 12.0
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapAdjustButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var tap: UITapGestureRecognizer = UITapGestureRecognizer(
        target: self,
        action: #selector(dismissKeyboard)
    )
    
    init(tags: [String], newsTagmakerDelegate: NewsTagmakerDelegate) {
        super.init(nibName: nil, bundle: nil)
        presenter = NewsTagmakerPresenter(viewController: self, delegate: newsTagmakerDelegate, tags: tags)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension NewsTagmakerViewController: NewsTagmakerProtocol {
    func setupNavigationBar() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.titleView = searchBar
    }
    
    func setupLayout() {
        [collectionView, adjustButton].forEach {
            view.addSubview($0)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(24.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalTo(adjustButton.snp.top)
        }
        
        adjustButton.snp.makeConstraints {
            $0.height.equalTo(60.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.bottom.equalToSuperview().inset(16.0)
        }
        
        tap.cancelsTouchesInView = false
        collectionView.addGestureRecognizer(tap)
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func dismissToNewListViewController() {
        dismiss(animated: true)
    }
    
    func showToast(with message: String) {
        view.makeToast(message)
    }
    
    func endEditing() {
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
}

private extension NewsTagmakerViewController {
    @objc func didTapRightBarButton() {
        presenter.setTags()
    }
    
    @objc func didTapAdjustButton() {
        presenter.didTapAdjustButton()
    }
    
    @objc func dismissKeyboard() {
        presenter.dismissKeyboard()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let estimatedHeight: CGFloat = 50
        let estimatedWidth: CGFloat = 100
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(estimatedWidth),
            heightDimension: .estimated(estimatedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
            leading: nil,
            top: .fixed(8),
            trailing: .fixed(8),
            bottom: .fixed(8)
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(estimatedHeight)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}


