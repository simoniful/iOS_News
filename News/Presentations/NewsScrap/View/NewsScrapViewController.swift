//
//  NewsScrapViewController.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/29.
//

import UIKit
import SnapKit

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
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
    
    func pushToNewsWebViewController(with scrapedNews: ScrapedNews) {
        let news = News(
            title: scrapedNews.title ?? "",
            originallink: scrapedNews.originallink ?? "",
            link: scrapedNews.link ?? "",
            desc: scrapedNews.desc ?? "",
            pubDate: scrapedNews.pubDate ?? "",
            isScraped: scrapedNews.isScraped
        )
        let newsWebViewController = NewsWebViewController(news: news)
        newsWebViewController.scrapedNews = scrapedNews
        navigationController?.pushViewController(newsWebViewController, animated: true)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func deleteTableRow(indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}


