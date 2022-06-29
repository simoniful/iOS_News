//
//  NewsScrapViewCell.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/29.
//

import UIKit
import SnapKit

final class NewsScrapViewCell: UITableViewCell {
    static let identifier = "NewsScrapViewCell"
    
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
    
    private lazy var monthDayLabel: UILabel = {
        let label = UILabel()
        label.text = "6 / 29"
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.text = "2022"
        label.font = .systemFont(ofSize: 12.0, weight: .medium)
        label.textColor = .tertiaryLabel
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.blue.cgColor
        contentView.frame = contentView.frame.inset(
            by: UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        )
    }
    
    func setup() {
        setupLayout()
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
    }
}

private extension NewsScrapViewCell {
    func setupLayout() {
        
        contentView.backgroundColor = .red
        [titleLabel, descriptionLabel, monthDayLabel, yearLabel].forEach {
            contentView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.
        }
    }
}
    
