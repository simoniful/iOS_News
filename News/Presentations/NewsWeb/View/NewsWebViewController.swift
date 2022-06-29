//
//  NewsWebViewController.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/24.
//

import UIKit
import SnapKit
import WebKit

final class NewsWebViewController: UIViewController {
    private var presenter: NewsWebPresenter!
    
    private let rightBarCopyButton = UIBarButtonItem(
        image: UIImage(systemName: "link"),
        style: .plain,
        target: self,
        action: #selector(didTapRightBarCopyButton)
    )
    
    private let rightBarBookmarkButton = UIBarButtonItem(
        image: UIImage(systemName: "bookmark"),
        style: .plain,
        target: self,
        action: #selector(didTapRightBarBookmarkButton)
    )
    
    private let webView = WKWebView()
    
    init(news: News) {
        super.init(nibName: nil, bundle: nil)
        presenter = NewsWebPresenter(viewController: self, news: news)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presenter.viewDidLoad()
    }
}

private extension NewsWebViewController {
    // Toast 구현
    @objc func didTapRightBarCopyButton() {
        presenter.didTapRightBarCopyButton()
    }
    
    @objc func didTapRightBarBookmarkButton() {
        presenter.didTapRightBarBookmarkButton()
    }
}

extension NewsWebViewController: NewsWebProtocol {
    func setupNavigationBar(with news: News) {
        navigationItem.title = news.title.htmlToString
        navigationItem.rightBarButtonItems = [rightBarCopyButton, rightBarBookmarkButton]
    }
    
    func setupWebView(with news: News) {
        guard let linkURL = URL(string: news.link) else {
            navigationController?.popViewController(animated: true)
            return
        }
        view = webView
        let urlRequest = URLRequest(url: linkURL)
        webView.load(urlRequest)
    }
    
    func setRightBarButton(with isScraped: Bool) {
        let imageName = isScraped ? "bookmark.fill" : "bookmark"
        navigationItem.rightBarButtonItems?[1].image = UIImage(systemName: imageName)
    }
}
