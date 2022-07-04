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
    func removeRightButton()
    func pushToNewsTagmakerViewController(with tags: [String])
    func changeNavigationTitleSize()
    func scrollToTop()
}

final class NewsListPresenter: NSObject {
    private weak var viewController: NewsListProtocol?
    private let newsSearchManager: NewsSearchManagerProtocol
    
    private var tags: [String] = ["IT", "주식", "개발", "코로나", "게임", "부동산", "메타버스"]
    var newsList: [News] = []
    
    private var currentKeyword: String = ""
    private var currentPage: Int = 0
    private var totalCount = 0
    private let display: Int = 20
    
    init(
        viewController: NewsListProtocol,
        newsSearchManager: NewsSearchManagerProtocol = NewsSearchManager()
    ) {
        self.viewController = viewController
        self.newsSearchManager = newsSearchManager
    }
    
    func viewDidLoad() {
        viewController?.setupLayout()
    }
    
    func viewWillAppear() {
        viewController?.setupNavigationBar()
    }
    
    func viewWillDisappear() {
        viewController?.removeRightButton()
        viewController?.changeNavigationTitleSize()
    }
    
    func didCalledRefresh() {
        requestNewsList(isNeededToReset: true)
    }
    
    func didTapRightBarButton() {
        viewController?.pushToNewsTagmakerViewController(with: tags)
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
        header.setup(tags: tags, delegate: self)
        return header
    }
}

extension NewsListPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = newsList[indexPath.row]
        viewController?.pushToNewsWebViewController(with: news)
    }
}

extension NewsListPresenter: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if newsList.count - 1 == indexPath.row && newsList.count < totalCount {
                requestNewsList(isNeededToReset: false)
            }
        }
    }
}

extension NewsListPresenter: NewsListViewHeaderDelegate {
    func didSelectTag(_ selectedIndex: Int) {
        currentKeyword = tags[selectedIndex]
        requestNewsList(isNeededToReset: true)
    }
}

extension NewsListPresenter: NewsTagmakerDelegate {
    func makeTags(_ tags: [String]) {
        self.tags = tags
        viewController?.reloadTableView()
    }
}

private extension NewsListPresenter {
    func requestNewsList(isNeededToReset: Bool) {
        if isNeededToReset {
            currentPage = 0
            totalCount = 0
            newsList = []
        }
        
        newsSearchManager.request(
            from: currentKeyword,
            display: display,
            start: (currentPage * display) + 1,
            completionHandler: {[weak self] result in
                switch result {
                case .success(let data):
                    let newValue = data.item
                    self?.newsList += newValue
                    self?.currentPage += 1
                    self?.totalCount = data.total
                    self?.viewController?.reloadTableView()
                    self?.viewController?.endRefreshing()
                    if isNeededToReset {
                        self?.viewController?.scrollToTop()
                    }
                case .failure(let error):
                    print(error)
                }
            })
    }
}


