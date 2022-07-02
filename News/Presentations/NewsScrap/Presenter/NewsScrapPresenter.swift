//
//  NewsScrapPresenter.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/29.
//

import UIKit

protocol NewsScrapProtocol: AnyObject {
    func setupNavigationBar()
    func setupLayout()
    func pushToNewsWebViewController(with scrapedNews: ScrapedNews)
    func reloadTableView()
}

final class NewsScrapPresenter: NSObject {
    private weak var viewController: NewsScrapProtocol?
    private let coreDataManager: CoreDataManagerProtocol
    private var scrapedNewsList: [ScrapedNews] = []
    
    init(
        viewController: NewsScrapProtocol,
        coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared
    ) {
        self.viewController = viewController
        self.coreDataManager = coreDataManager
    }
    
    func viewDidLoad() {
        requestScrapedNewsList()
        viewController?.setupNavigationBar()
        viewController?.setupLayout()
    }
    
    func viewWillAppear() {
        requestScrapedNewsList()
    }
}

extension NewsScrapPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scrapedNewsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsScrapViewCell.identifier, for: indexPath) as? NewsScrapViewCell else { return UITableViewCell() }
        let news = scrapedNewsList[indexPath.row]
        cell.setup(scrapedNews: news)
        return cell
    }
}

extension NewsScrapPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = scrapedNewsList[indexPath.row]
        viewController?.pushToNewsWebViewController(with: news)
    }
}

private extension NewsScrapPresenter {
    func requestScrapedNewsList() {
        scrapedNewsList = coreDataManager.fetchData(request: ScrapedNews.fetchRequest())
        self.viewController?.reloadTableView()
    }
}

