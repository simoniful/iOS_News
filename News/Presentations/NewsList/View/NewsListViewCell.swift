//
//  NewsListViewCell.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/24.
//

import UIKit
import SnapKit

final class NewsListViewCell: UITableViewCell {
    static let identifier = "NewsListViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "기사 제목"
        label.font = .systemFont(ofSize: 15.0, weight: .semibold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "기사 내용"
        label.font = .systemFont(ofSize: 13.0, weight: .medium)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "작성일자"
        label.font = .systemFont(ofSize: 12.0, weight: .medium)
        label.textColor = .systemGray
        return label
    }()
    
    func setup(news: News) {
        setupLayout()
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
        titleLabel.text = news.title.htmlToString
        descriptionLabel.text = news.desc.htmlToString
        dateLabel.text = news.pubDate.toDate()?.toString(pattern: .custom)
    }
}

private extension NewsListViewCell {
    func setupLayout() {
        [titleLabel, descriptionLabel, dateLabel].forEach {
            addSubview($0)
        }
        
        let superViewInset: CGFloat = 16.0
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(superViewInset)
            $0.leading.equalToSuperview().inset(superViewInset)
            $0.trailing.equalToSuperview().inset(48.0)
        }
        
        let verticalSpacing: CGFloat = 4.0
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(verticalSpacing)
            $0.leading.trailing.equalTo(titleLabel)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(verticalSpacing)
            $0.leading.trailing.equalTo(titleLabel)
            $0.bottom.equalToSuperview().inset(superViewInset)
        }
    }
}
