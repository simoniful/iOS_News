//
//  Coordinator.swift
//  News
//
//  Created by Sang hun Lee on 2022/07/08.
//

import UIKit

protocol Coordinator: AnyObject {
    var delegate: CoordinatorDelegate? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var type: CoordinatorStyleCase { get }

    func start()
    func finish()

    init(_ navigationController: UINavigationController)
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        delegate?.didFinish(childCoordinator: self)
    }

    func changeAnimation() {
        if let window = UIApplication.shared.windows.first {
            UIView.transition(with: window,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: nil)
        }
    }
}
