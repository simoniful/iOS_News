//
//  NewsTabCoordinator.swift
//  News
//
//  Created by Sang hun Lee on 2022/07/08.
//

import UIKit

final class NewsTabCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    var type: CoordinatorStyleCase = .tab

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
        self.tabBarController = UITabBarController()
    }

    func start() {
        let pages: [TabBarPageCase] = TabBarPageCase.allCases
        let controllers: [UINavigationController] = pages.map({
            self.createTabNavigationController(of: $0)
        })
        self.configureTabBarController(with: controllers)
    }

    func currentPage() -> TabBarPageCase? {
        TabBarPageCase(index: self.tabBarController.selectedIndex)
    }

    func selectPage(_ page: TabBarPageCase) {
        self.tabBarController.selectedIndex = page.pageOrderNumber
    }

    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPageCase(index: index) else { return }
        self.tabBarController.selectedIndex = page.pageOrderNumber
    }

    private func configureTabBarController(with tabViewControllers: [UIViewController]) {
        self.tabBarController.setViewControllers(tabViewControllers, animated: true)
        self.tabBarController.selectedIndex = TabBarPageCase.news.pageOrderNumber
        self.changeAnimation()
        self.navigationController.pushViewController(tabBarController, animated: true)
    }

    private func configureTabBarItem(of page: TabBarPageCase) -> UITabBarItem {
        return UITabBarItem(
            title: page.pageTitle,
            image: UIImage(systemName: page.tabIconName()),
            tag: page.pageOrderNumber
        )
    }

    private func createTabNavigationController(of page: TabBarPageCase) -> UINavigationController {
        let tabNavigationController = UINavigationController()
        tabNavigationController.setNavigationBarHidden(false, animated: false)
        tabNavigationController.tabBarItem = self.configureTabBarItem(of: page)
        connectTabCoordinator(of: page, to: tabNavigationController)
        return tabNavigationController
    }

    private func connectTabCoordinator(of page: TabBarPageCase, to tabNavigationController: UINavigationController) {
        switch page {
        case .news:
            let newsListCoordinator = NewsListCoordinator(tabNavigationController)
            newsListCoordinator.delegate = self
            self.childCoordinators.append(newsListCoordinator)
            newsListCoordinator.start()
        case .bookmark:
            let newsScrapCoordinator = NewsScrapCoordinator(tabNavigationController)
            newsScrapCoordinator.delegate = self
            self.childCoordinators.append(newsScrapCoordinator)
            newsScrapCoordinator.start()
        }
    }
}

extension NewsTabCoordinator: CoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        self.childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
//        if childCoordinator.type == . {
//            self.navigationController.viewControllers.removeAll()
//            self.delegate?.didFinish(childCoordinator: self)
//        }
    }
}
