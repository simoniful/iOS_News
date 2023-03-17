//
//  NewsScrapCoordinator.swift
//  News
//
//  Created by Sang hun Lee on 2022/07/08.
//

import UIKit

final class NewsScrapCoordinator: Coordinator {
    var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorStyleCase = .bookmark
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = NewsScrapViewController(
            viewModel: NewsScrapViewModel(
                coordinator: self
            )
        )
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pushNewsWebViewController(news: News, scrapedNews: ScrapedNews?) {
        let vc = NewsWebViewController(
            viewModel: NewsWebViewModel(
                coordinator: self,
                news: news,
                scrapedNews: scrapedNews
            )
        )
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
}
