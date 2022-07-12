//
//  MockNewsListCoordinator.swift
//  NewsTests
//
//  Created by Sang hun Lee on 2022/07/12.
//

import UIKit
@testable import News

final class MockNewsListCoordinator: Coordinator {
    var isCalledStart = false
    
    var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]
    var type: CoordinatorStyleCase
    
    func start() {
        isCalledStart = true
    }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
