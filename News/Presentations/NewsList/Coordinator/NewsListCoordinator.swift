//
//  NewsListCoordinator.swift
//  News
//
//  Created by Sang hun Lee on 2022/07/08.
//

import UIKit

final class NewsListCoordinator: Coordinator {
    var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorStyleCase = .news
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = NewsListViewController(
            viewModel: NewsListViewModel(
                coordinator: self,
                searchUseCase: SearchUseCase(
                    repository: NewsSearchManager()
                )
            )
        )
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showNewsWebViewController(news: News, scrapedNews: ScrapedNews?) {
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
    
    func presentNewsTagmakerViewController() {
        
    }
    
    func popToRootViewController(message: String? = nil) {
        navigationController.popToRootViewController(animated: true)
        if let message = message {
            navigationController.view.makeToast(message, position: .top)
        }
    }
}
