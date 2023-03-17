//
//  NewsTagmakerView.swift
//  
//
//  Created by Sang hun Lee on 2022/07/11.
//

import UIKit

final class NewsTagmakerView: UIView {
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    lazy var rightBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = UIImage(systemName: "plus")
        barButton.style = .plain
        return barButton
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(
            NewsTagmakerViewCell.self,
            forCellWithReuseIdentifier: NewsTagmakerViewCell.identifier
        )
        return collectionView
    }()
    
    lazy var adjustButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("적용하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19.0, weight: .semibold)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 12.0
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewsTagmakerView: ViewRepresentable {
    func setupView() {
        [collectionView, adjustButton].forEach {
            addSubview($0)
        }
    }
    
    func setupConstraints() {
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
