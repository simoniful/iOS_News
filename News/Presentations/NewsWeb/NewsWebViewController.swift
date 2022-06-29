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
    private let rightBarButtonItem = UIBarButtonItem(
        image: UIImage(systemName: "link"),
        style: .plain,
        target: self,
        action: #selector(didTapRightBarButtonItem)
    )
    
    private let webView = WKWebView()
    
    private let news: News
    
    init(news: News) {
        self.news = news
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupWebView()
    }
}

private extension NewsWebViewController {
    func setupNavigationBar() {
        navigationItem.title = news.title.htmlToString
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupWebView() {
        guard let linkURL = URL(string: news.link) else {
            navigationController?.popViewController(animated: true)
            return
        }
        view = webView
        let urlRequest = URLRequest(url: linkURL)
        webView.load(urlRequest)
    }
    
    // Toast 구현
    @objc func didTapRightBarButtonItem() {
        UIPasteboard.general.string = news.originallink
    }
}
