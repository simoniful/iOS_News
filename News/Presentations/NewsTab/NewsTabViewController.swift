//
//  NewsTabViewController.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/29.
//

import UIKit

final class NewsTabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let translateViewController = UINavigationController(rootViewController: NewsListViewController())
        translateViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("News", comment: "뉴스리스트"),
            image: UIImage(systemName: "newspaper"),
            selectedImage: UIImage(systemName: "newspaper.fill")
        )
        
        let bookmarkViewController = UINavigationController(rootViewController: NewsScrapViewController())
        bookmarkViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString("Bookmark", comment: "스크랩"),
            image: UIImage(systemName: "bookmark"),
            selectedImage: UIImage(systemName: "bookmark.fill")
        )
        
        self.viewControllers = [translateViewController, bookmarkViewController]
        self.tabBar.tintColor = UIColor.systemOrange
    }
}
