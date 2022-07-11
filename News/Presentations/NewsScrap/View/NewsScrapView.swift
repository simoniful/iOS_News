//
//  NewsScrapView.swift
//  News
//
//  Created by Sang hun Lee on 2022/07/11.
//

import Foundation
import UIKit

final class NewsScrapView: UIView {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsScrapViewCell.self, forCellReuseIdentifier: NewsScrapViewCell.identifier)
        tableView.estimatedRowHeight = 100.0
        return tableView
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

extension NewsScrapView: ViewRepresentable {
    func setupView() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
