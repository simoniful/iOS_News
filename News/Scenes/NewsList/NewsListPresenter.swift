//
//  NewsListPresenter.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/24.
//

import UIKit

protocol NewsListProtocol: AnyObject {
    func setupNavigationBar()
    func setupLayout()
    func endRefreshing()
    func pushToNewsWebViewController()
}

final class NewsListPresenter: NSObject {
    private weak var viewController: NewsListProtocol?
    
    init(viewController: NewsListProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupLayout()
    }
    
    func didCalledRefresh() {
        viewController?.endRefreshing()
    }
}

extension NewsListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListViewCell.identifier, for: indexPath) as? NewsListViewCell else { return UITableViewCell() }
        cell.setup()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: NewsListViewHeader.identifier) as? NewsListViewHeader else { return UITableViewHeaderFooterView() }
        header.setup()
        return header
    }
}

extension NewsListPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController?.pushToNewsWebViewController()
    }
}
