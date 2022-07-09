//
//  NewsListViewController.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class NewsListViewController: UIViewController {
    private var disposeBag = DisposeBag()
    
    private let newsListView = NewsListView()
    private var viewModel: NewsListViewModel
    private var input: NewsListViewModel.Input
    private var output: NewsListViewModel.Output
    
    init(viewModel: NewsListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        input = NewsListViewModel.Input()
        output = viewModel.transform(input: input)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = newsListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeRightButton()
        changeNavigationTitleSize()
    }
}

private extension NewsListViewController {
    func setupNavigationBar() {
        title = "NEWS"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.addSubview(newsListView.rightBarButton)
        
        guard let targetView = self.navigationController?.navigationBar else { return }

        newsListView.rightBarButton.snp.makeConstraints {
            $0.trailing.equalTo(targetView.snp.trailing).inset(16.0)
            $0.bottom.equalTo(targetView.snp.bottom).inset(8.0)
            $0.width.equalTo(30.0)
            $0.height.equalTo(30.0)
        }
    }
    
    func removeRightButton() {
        guard let subviews = self.navigationController?.navigationBar.subviews else { return }
        for view in subviews{
            if view.tag != 0 {
                view.removeFromSuperview()
            }
        }
    }
    
    func changeNavigationTitleSize() {
        navigationItem.title = ""
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
    func bind() {
        
    }

    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    
    func pushToNewsTagmakerViewController(with tags: [String]) {
        let newsTagmakerViewController = UINavigationController(
            rootViewController: NewsTagmakerViewController(
                tags: tags,
                newsTagmakerDelegate: presenter
            )
        )
        newsTagmakerViewController.modalPresentationStyle = .fullScreen
        
        navigationController?.present(newsTagmakerViewController, animated: true)
    }
    
    func scrollToTop() {
        tableView.scrollToRow(
            at: IndexPath(row: 0, section: 0),
            at: .top,
            animated: true
        )
    }
}

//private extension NewsListViewController {
//    @objc func didCalledRefresh() {
//        presenter.didCalledRefresh()
//    }
//
//    @objc func didTapRightBarButton() {
//        presenter.didTapRightBarButton()
//    }
//}

