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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        NewsSearchManager()
            .request(from: "아이폰", display: 20, start: 1) { news in
                print(news)
            }
    }
}

extension NewsListViewController: NewsListProtocol {
    func setupNavigationBar() {
        navigationItem.title = "NEWS"
        navigationController?.navigationBar.prefersLargeTitles = true
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
    
    func pushToNewsWebViewController() {
        let newsWebViewController = NewsWebViewController()
        navigationController?.pushViewController(newsWebViewController, animated: true)
    }
}

private extension NewsListViewController {
    @objc func didCalledRefresh() {
        presenter.didCalledRefresh()
    }
}

