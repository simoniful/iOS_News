//
//  NewsWebPresenter.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/29.
//

import UIKit
import CoreData

protocol NewsWebProtocol: AnyObject {
    func setupNavigationBar(with news: News)
    func setupWebView(with news: News)
    func setRightBarButton(with isScraped: Bool)
    func showToast(with message: String)
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
        // TODO: 저장될 때 내부 데이터가 특정 값으로 있는지 여부 확인 후 되도록 구현
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
