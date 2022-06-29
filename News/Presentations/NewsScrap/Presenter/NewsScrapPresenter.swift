//
//  NewsScrapPresenter.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/29.
//

import Foundation
import UIKit

protocol NewsScrapProtocol: AnyObject {
    func setupNavigationBar()
    func setupLayout()
    func pushToNewsWebViewController(with news: News)
}

final class NewsScrapPresenter: NSObject {
    private weak var viewController: NewsScrapProtocol?
    private let coreDataManager: CoreDataManagerProtocol
    
    init(
        viewController: NewsScrapProtocol,
        coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared
    ) {
        self.viewController = viewController
        self.coreDataManager = coreDataManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupLayout()
    }
}

extension NewsScrapPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsScrapViewCell.identifier, for: indexPath) as? NewsScrapViewCell else { return UITableViewCell() }
        // let news = scrapedNewsList[indexPath.row]
        cell.setup()
        return cell
    }
}

extension NewsScrapPresenter: UITableViewDelegate {
  
}

