//
//  NewsWebPresenter.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/29.
//

import UIKit
import CoreData
import WebKit

protocol NewsWebProtocol: AnyObject {
    func setupNavigationBar(with news: News)
    func setupWebView(with news: News)
    func setRightBarButton(with isScraped: Bool)
    func showToast(with message: String)
    func stopIndicator()
}

final class NewsWebPresenter: NSObject {
    private weak var viewController: NewsWebProtocol?
    private let coreDataManager: CoreDataManagerProtocol
    var news: News
    var scrapedNews: ScrapedNews?
    
    init(
        viewController: NewsWebProtocol,
        coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared,
        news: News,
        scrapedNews: ScrapedNews?
    ) {
        self.viewController = viewController
        self.coreDataManager = coreDataManager
        self.news = news
        self.scrapedNews = scrapedNews
    }
    
    func viewDidLoad() {
        viewController?.setupWebView(with: news)
        viewController?.setupNavigationBar(with: news)
        viewController?.setRightBarButton(with: news.isScraped)
    }
    
    func didTapRightBarCopyButton() {
        UIPasteboard.general.string = news.originallink
        viewController?.showToast(with: "클립보드에 복사되었습니다")
    }
    
    func didTapRightBarBookmarkButton() {
        news.isScraped.toggle()
        if news.isScraped {
            coreDataManager.saveNews(item: news)
            let request: NSFetchRequest<ScrapedNews> = ScrapedNews.fetchRequest()
            request.predicate = NSPredicate(format: "title CONTAINS %@", news.title)
            self.scrapedNews = coreDataManager.fetchData(request: request).first
        } else {
            if let scrapedNews = scrapedNews {
                coreDataManager.deleteNews(object: scrapedNews)
            }
        }
        viewController?.setRightBarButton(with: news.isScraped)
    }
}

extension NewsWebPresenter: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        viewController?.stopIndicator()
    }
}
