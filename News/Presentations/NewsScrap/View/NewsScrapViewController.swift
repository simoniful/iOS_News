//
//  NewsScrapViewController.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/29.
//

import UIKit

final class NewsScrapViewController: UIViewController {
    private lazy var presenter = NewsScrapPresenter(viewController: self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter
        tableView.delegate = presenter
        tableView.register(NewsScrapViewCell.self, forCellReuseIdentifier: NewsScrapViewCell.identifier)
        tableView.estimatedRowHeight = 100.0
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension NewsScrapViewController: NewsScrapProtocol {
    func setupNavigationBar() {
        navigationItem.title = "Bookmarks"
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func pushToNewsWebViewController(with news: News) {
        
    }
}


