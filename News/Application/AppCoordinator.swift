//
//  AppCoordinator.swift
//  News
//
//  Created by Sang hun Lee on 2022/07/08.
//

import UIKit

final class AppCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .app

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
    }

    func start() {
        connectTabBarFlow()
    }

    private func connectTabBarFlow() {
        let newsTabCoordinator = NewsTabCoordinator(self.navigationController)
        newsTabCoordinator.delegate = self
        newsTabCoordinator.start()
        childCoordinators.append(newsTabCoordinator)
    }
}

extension AppCoordinator: CoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        finish()
    }
}
