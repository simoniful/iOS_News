//
//  SceneDelegate.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let nav = UINavigationController()
        coordinator = AppCoordinator(nav)
        coordinator?.start()
        window?.tintColor = .systemOrange
        window?.backgroundColor = .systemBackground
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

