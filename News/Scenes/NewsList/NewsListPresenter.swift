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
    // 지금까지 request된, 가지고 있는 보여주고 있는 page가 어디인지 파악
    private var currentPage: Int = 0
    // 한 페이지에 최대 몇 개 까지 보여줄건지
    private let display: Int = 20
    
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
    
    // 해당 방식으로 구현 시 애니메이션 튀는 경우 발생, 보다 안정된 pagenation 필요
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentRow = indexPath.row
        
        guard (currentRow % 20) == display - 3 && (currentRow / display) == (currentPage - 1) else { return }
        
        requestNewsList()
    }
}

private extension NewsListPresenter {
    func requestNewsList() {
        newsSearchManager.request(
            from: currentKeyword,
            display: display,
            start: (currentPage * display) + 1
        ) { [weak self] newValue in
            self?.newsList += newValue
            self?.currentPage += 1
            self?.viewController?.reloadTableView()
        }
    }
}
