//
//  NewsListPresenter.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/24.
//

import UIKit

protocol NewsListProtocol: AnyObject {
    func setupNavigationBar()
    func setupLayout()
    func endRefreshing()
    func pushToNewsWebViewController(with news: News)
    func reloadTableView()
}

final class NewsListPresenter: NSObject {
    private weak var viewController: NewsListProtocol?
    private let newsSearchManager: NewsSearchManagerProtocol
    
    private var newsList: [News] = []
    private var currentKeyword: String = "아이폰"
    
    init(
        viewController: NewsListProtocol,
        newsSearchManager: NewsSearchManagerProtocol = NewsSearchManager()
    ) {
        self.viewController = viewController
        self.newsSearchManager = newsSearchManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupLayout()
        requestNewsList()
    }
    
    func didCalledRefresh() {
        viewController?.endRefreshing()
    }
}

extension NewsListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListViewCell.identifier, for: indexPath) as? NewsListViewCell else { return UITableViewCell() }
        let news = newsList[indexPath.row]
        cell.setup(news: news)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsListViewHeader.identifier) as? NewsListViewHeader else { return UITableViewHeaderFooterView() }
        header.setup()
        return header
    }
}

extension NewsListPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = newsList[indexPath.row]
        viewController?.pushToNewsWebViewController(with: news)
    }
}

private extension NewsListPresenter {
    func requestNewsList() {
        newsSearchManager.request(
            from: currentKeyword,
            display: 20,
            start: 1
        ) { [weak self] newValue in
            self?.newsList += newValue
            self?.viewController?.reloadTableView()
        }
    }
}
