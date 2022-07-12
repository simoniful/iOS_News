//
//  NewsTagmakerViewController.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/30.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class NewsTagmakerViewController: UIViewController {
    private var disposeBag = DisposeBag()
    
    private let newsTagmakerView = NewsTagmakerView()
    private var viewModel: NewsTagmakerViewModel
    private lazy var input = NewsTagmakerViewModel.Input(
        didSelectItemAt: newsTagmakerView.collectionView.rx.itemSelected.asSignal(),
        searchBarText: newsTagmakerView.searchBar.rx.text.orEmpty.asSignal(onErrorJustReturn: ""),
        searchBarSearchButtonTapped: newsTagmakerView.searchBar.rx.searchButtonClicked.asSignal(),
        rightBarButtonTapped: newsTagmakerView.rightBarButton.rx.tap.asSignal(),
        adjustButtonTapped: newsTagmakerView.adjustButton.rx.tap.asSignal(),
        willBeginDragging: newsTagmakerView.collectionView.rx.willBeginDragging.asSignal()
    )
    private lazy var output = viewModel.transform(input: input)
    
    private lazy var tap: UITapGestureRecognizer = UITapGestureRecognizer(
        target: self,
        action: #selector(dismissKeyboard)
    )
    
    init(viewModel: NewsTagmakerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = newsTagmakerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTapGesture()
        bind()
    }
}

private extension NewsTagmakerViewController {
    func setupNavigationBar() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = newsTagmakerView.rightBarButton
        navigationItem.titleView = newsTagmakerView.searchBar
    }
    
    func setupTapGesture() {
        tap.cancelsTouchesInView = false
        newsTagmakerView.collectionView.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        endEditing()
    }
    
    func endEditing() {
        newsTagmakerView.searchBar.resignFirstResponder()
        newsTagmakerView.searchBar.text = ""
    }
    
    func bind() {
        output.tags
            .drive(
                newsTagmakerView.collectionView.rx.items(
                    cellIdentifier: NewsTagmakerViewCell .identifier, cellType: NewsTagmakerViewCell.self
                )
            ) { index, tag, cell in
                cell.setup(tag: tag)
            }
            .disposed(by: disposeBag)
        
        output.showToastAction
            .emit(onNext: { [weak self] text in
                self?.view.makeToast(text, position: .center)
            })
            .disposed(by: disposeBag)
        
        output.endEditing
            .emit(onNext: { [weak self] _ in
                self?.endEditing()
            })
            .disposed(by: disposeBag)
    }
}



