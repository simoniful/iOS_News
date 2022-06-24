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
    
    private let rightBarButtonItem2 = UIBarButtonItem(
        image: UIImage(systemName: "link"),
        style: .plain,
        target: self,
        action: #selector(didTapRightBarButtonItem)
    )
    
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupWebView()
    }
}

private extension NewsWebViewController {
    func setupNavigationBar() {
        navigationItem.title = "기사 제목"
        navigationItem.rightBarButtonItems = [rightBarButtonItem, rightBarButtonItem2]
    }
    
    func setupWebView() {
        guard let linkURL = URL(string: "https://fastcampus.co.kr") else {
            navigationController?.popViewController(animated: true)
            return
        }
        view = webView
        let urlRequest = URLRequest(url: linkURL)
        webView.load(urlRequest)
    }
    
    @objc func didTapRightBarButtonItem() {
        UIPasteboard.general.string = "기사 링크"
    }
}
