//
//  NewsScrapPresenter.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/29.
//

import UIKit
import CoreData

protocol NewsScrapProtocol: AnyObject {
    func setupNavigationBar()
    func setupLayout()
    func pushToNewsWebViewController(with scrapedNews: ScrapedNews, news: News)
    func reloadTableView()
    func deleteTableRow(indexPath: IndexPath)
}

final class NewsScrapPresenter: NSObject {
    private weak var viewController: NewsScrapProtocol?
    private let coreDataManager: CoreDataManagerProtocol
    var scrapedNewsList: [ScrapedNews] = []
    
    init(
        viewController: NewsScrapProtocol,
        coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared
    ) {
        self.viewController = viewController
        self.coreDataManager = coreDataManager
    }
    
    func viewDidLoad() {
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
        let scrapedNews = scrapedNewsList[indexPath.row]
        let news = News(
            title: scrapedNews.title ?? "",
            originallink: scrapedNews.originallink ?? "",
            link: scrapedNews.link ?? "",
            desc: scrapedNews.desc ?? "",
            pubDate: scrapedNews.pubDate ?? "",
            isScraped: scrapedNews.isScraped
        )
        viewController?.pushToNewsWebViewController(with: scrapedNews, news: news)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deleteOne = scrapedNewsList[indexPath.row]
            coreDataManager.deleteNews(object: deleteOne)
            scrapedNewsList.remove(at: indexPath.row)
            viewController?.deleteTableRow(indexPath: indexPath)
        }
    }
}

private extension NewsScrapPresenter {
    func requestScrapedNewsList() {
        scrapedNewsList = coreDataManager.fetchData(request: ScrapedNews.fetchRequest())
        self.viewController?.reloadTableView()
    }
}

