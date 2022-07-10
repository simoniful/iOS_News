//
//  NewsWebViewController.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/24.
//

import UIKit
import RxSwift
import RxCocoa
import WebKit
import SnapKit
import Toast_Swift

final class NewsWebViewController: UIViewController {
    private var disposeBag = DisposeBag()
    
    private let newsWebView = NewsWebView()
    private var viewModel: NewsWebViewModel
    private var input: NewsWebViewModel.Input
    private var output: NewsWebViewModel.Output

    init(viewModel: NewsWebViewModel) {
        self.viewModel = viewModel
        input = NewsWebViewModel.Input(
            rightBarCopyButtonTapped: newsWebView.rightBarCopyButton.rx.tap.asSignal(),
            rightBarBookmarkButtonTapped: newsWebView.rightBarBookmarkButton.rx.tap.asSignal(),
            webViewLoaded:
                newsWebView.webView.rx.didFinishLoad
        )
        output = viewModel.transform(input: input)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = newsWebView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar(with: viewModel.news)
        setupWebView(with: viewModel.news)
        bind()
    }
}

private extension NewsWebViewController {
    func setupNavigationBar(with news: News) {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = news.title
        navigationItem.rightBarButtonItems = [
            newsWebView.rightBarCopyButton, newsWebView.rightBarBookmarkButton
        ]
    }
    
    func setupWebView(with news: News) {
        guard let linkURL = URL(string: news.link) else { return }
        let urlRequest = URLRequest(url: linkURL)
        newsWebView.webView.load(urlRequest)
        newsWebView.webView.allowsBackForwardNavigationGestures = true
        newsWebView.webView.becomeFirstResponder()
    }
    
    func setupRightBarButton(with isScraped: Bool) {
        let imageName = isScraped ? "bookmark.fill" : "bookmark"
        navigationItem.rightBarButtonItems?.last?.image = UIImage(systemName: imageName)
    }
    
    func bind() {
        output.showToastAction
            .emit(onNext: { [weak self] text in
                self?.view.makeToast(text)
            })
            .disposed(by: disposeBag)
        
        output.indicatorAction
            .drive(onNext: {
                $0 ? self.newsWebView.indicatorView.startAnimating() : self.newsWebView.indicatorView.stopAnimating()
            })
            .disposed(by: disposeBag)
        
        output.scrapedState
            .drive(onNext: {
                self.setupRightBarButton(with: $0)
            })
            .disposed(by: disposeBag)
    }
}

