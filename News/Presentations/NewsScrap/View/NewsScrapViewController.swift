//
//  NewsScrapViewController.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/29.
//

import UIKit
import SnapKit

final class NewsScrapViewController: UIViewController {
    private var presenter: NewsScrapPresenter!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter
        tableView.delegate = presenter
        tableView.register(NewsScrapViewCell.self, forCellReuseIdentifier: NewsScrapViewCell.identifier)
        tableView.estimatedRowHeight = 100.0
        return tableView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        presenter = NewsScrapPresenter(viewController: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}

extension NewsScrapViewController: NewsScrapProtocol {
    func setupNavigationBar() {
        navigationItem.title = "Bookmark"
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func pushToNewsWebViewController(with scrapedNews: ScrapedNews, news: News) {
//        let newsWebViewController = NewsWebViewController(news: news, scrapedNews: scrapedNews)
//        navigationController?.pushViewController(newsWebViewController, animated: true)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func deleteTableRow(indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}


