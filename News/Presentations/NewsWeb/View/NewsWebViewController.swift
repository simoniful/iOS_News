//
//  NewsWebViewController.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/24.
//

import UIKit
import SnapKit
import WebKit
import Toast_Swift

final class NewsWebViewController: UIViewController {
    private var presenter: NewsWebPresenter!
    var scrapedNews: ScrapedNews? {
        didSet {
            presenter.scrapedNews = self.scrapedNews
        }
    }
    
    private lazy var rightBarCopyButton = UIBarButtonItem(
        image: UIImage(systemName: "link"),
        style: .plain,
        target: self,
        action: #selector(didTapRightBarCopyButton)
    )
    
    private lazy var rightBarBookmarkButton = UIBarButtonItem(
        image: UIImage(systemName: "bookmark"),
        style: .plain,
        target: self,
        action: #selector(didTapRightBarBookmarkButton)
    )
    
    private let webView = WKWebView()
    
    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.hidesWhenStopped = true
        indicatorView.color = .systemGray
        indicatorView.backgroundColor = .black
        indicatorView.alpha = 0.4
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.startAnimating()
        return indicatorView
    }()
    
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
        
        [webView, indicatorView].forEach {
            view.addSubview($0)
        }
        
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        indicatorView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            
        }
        
        let urlRequest = URLRequest(url: linkURL)
        webView.load(urlRequest)
        webView.allowsBackForwardNavigationGestures = true
        webView.becomeFirstResponder()
        webView.navigationDelegate = presenter
    }
    
    func setRightBarButton(with isScraped: Bool) {
        let imageName = isScraped ? "bookmark.fill" : "bookmark"
        navigationItem.rightBarButtonItems?[1].image = UIImage(systemName: imageName)
    }
    
    func showToast(with message: String) {
        view.makeToast(message)
    }
    
    func stopIndicator() {
        indicatorView.stopAnimating()
    }
}
