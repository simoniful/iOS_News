//
//  CoordinatorDelegate.swift
//  News
//
//  Created by Sang hun Lee on 2022/07/08.
//

import Foundation

protocol CoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}
