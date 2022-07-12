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
    
    func presentNewsTagmakerViewController(
        tags: [String], newsTagmakerDelegate: NewsTagmakerDelegate
    ) {
        let vc = UINavigationController(
            rootViewController: NewsTagmakerViewController(
                viewModel: NewsTagmakerViewModel(
                    coordinator: self,
                    newsTagmakerDelegate: newsTagmakerDelegate,
                    tags: tags
                )
            )
        )
        vc.modalPresentationStyle = .fullScreen
        navigationController.present(vc, animated: true)
    }
    
    func dismissToNewsListViewController(message: String? = nil) {
        navigationController.dismiss(animated: true) {
            if let message = message {
                self.navigationController.view.makeToast(message, position: .bottom)
            }
        }
    }
    
    func popToRootViewController(message: String? = nil) {
        navigationController.popToRootViewController(animated: true)
        if let message = message {
            navigationController.view.makeToast(message, position: .top)
        }
    }
}
