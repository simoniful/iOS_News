//
//  NewsWebPresenter.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/29.
//

import UIKit

protocol NewsWebProtocol: AnyObject {
    func setupNavigationBar(with news: News)
    func setupWebView(with news: News)
    func setRightBarButton(with isScraped: Bool)
}

final class NewsWebPresenter: NSObject {
    private weak var viewController: NewsWebProtocol?
    private let coreDataManager: CoreDataManagerProtocol
    var news: News
    var scrapedNews: ScrapedNews?
    
    init(
        viewController: NewsWebProtocol,
        coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared,
        news: News
    ) {
        self.viewController = viewController
        self.coreDataManager = coreDataManager
        self.news = news
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar(with: news)
        viewController?.setRightBarButton(with: news.isScraped)
        viewController?.setupWebView(with: news)
    }
    
    func didTapRightBarCopyButton() {
        UIPasteboard.general.string = news.originallink
    }
    
    func didTapRightBarBookmarkButton() {
        news.isScraped.toggle()
        if news.isScraped {
            coreDataManager.saveNews(item: news)
        } else {
            if let scrapedNews = scrapedNews {
                coreDataManager.deleteNews(object: scrapedNews)
            }
        }
        viewController?.setRightBarButton(with: news.isScraped)
    }
}
