//
//  NewsListViewController.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/24.
//

import UIKit
import SnapKit

class NewsListViewController: UIViewController {
    private lazy var presenter = NewsListPresenter(viewController: self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter
        tableView.delegate = presenter
        tableView.register(NewsListViewCell.self, forCellReuseIdentifier: NewsListViewCell.identifier)
        tableView.register(NewsListViewHeader.self, forHeaderFooterViewReuseIdentifier: NewsListViewHeader.identifier)
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didCalledRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var rightBarButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(
            pointSize: 22.0,
            weight: .bold,
            scale: .large
        )
        let largeBoldPlus = UIImage(
            systemName: "plus.circle",
            withConfiguration: largeConfig
        )
        button.setImage(largeBoldPlus, for: .normal)
        button.addTarget(self, action: #selector(didTapRightBarButton), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
        // navigationController?.navigationBar.prefersLargeTitles = false
    }
}

extension NewsListViewController: NewsListProtocol {
    func setupNavigationBar() {
        navigationItem.title = "NEWS"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.addSubview(rightBarButton)
        
        guard let targetView = self.navigationController?.navigationBar else { return }

        rightBarButton.snp.makeConstraints {
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
    
    func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    func pushToNewsWebViewController(with news: News) {
        let newsWebViewController = NewsWebViewController(news: news)
        navigationController?.pushViewController(newsWebViewController, animated: true)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func pushToNewsTagmakerViewController(with tags: [String]) {
        let newsTagmakerViewController = UINavigationController(rootViewController: NewsTagmakerViewController(tags: tags, newsTagmakerDelegate: presenter))
        newsTagmakerViewController.modalPresentationStyle = .fullScreen
        present(newsTagmakerViewController, animated: true)
    }
}

private extension NewsListViewController {
    @objc func didCalledRefresh() {
        presenter.didCalledRefresh()
    }
    
    @objc func didTapRightBarButton() {
        presenter.didTapRightBarButton()
    }
}

