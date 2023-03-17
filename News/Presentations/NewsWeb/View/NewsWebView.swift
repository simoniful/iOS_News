//
//  NewsWebView.swift
//  News
//
//  Created by Sang hun Lee on 2022/07/08.
//

import UIKit
import WebKit
import SnapKit

final class NewsWebView: UIView {
    lazy var rightBarCopyButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = UIImage(systemName: "link")
        barButton.style = .plain
        return barButton
    }()
    
    lazy var rightBarBookmarkButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = UIImage(systemName: "bookmark")
        barButton.style = .plain
        return barButton
    }()
    
    lazy var webView = WKWebView()
    
    lazy var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.hidesWhenStopped = true
        indicatorView.color = .systemGray
        indicatorView.backgroundColor = .black
        indicatorView.alpha = 0.4
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewsWebView: ViewRepresentable {
    func setupView() {
        [webView, indicatorView].forEach {
            addSubview($0)
        }
    }
    
    func setupConstraints() {
        webView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        indicatorView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
