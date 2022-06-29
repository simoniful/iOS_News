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
    
    private lazy var reportStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4.0
        [titleLabel, descriptionLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private lazy var colorBlock: UIView = {
        let view = UIView()
        view.addSubview(dateStackView)
        view.backgroundColor = .systemOrange
        return view
    }()
    
    private lazy var monthDayLabel: UILabel = {
        let label = UILabel()
        label.text = "6.29(수)"
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.text = "2022"
        label.font = .systemFont(ofSize: 12.0, weight: .semibold)
        label.textColor = .tertiaryLabel
        return label
    }()
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4.0
        [monthDayLabel, yearLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.alignment = .center
        return stackView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemOrange.cgColor
        contentView.layer.cornerRadius = 8.0
        contentView.clipsToBounds = true
        contentView.frame = contentView.frame.inset(
            by: UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)
        )
    }
    
    func setup(scrapedNews: ScrapedNews) {
        setupLayout()
        selectionStyle = .none
        // TODO: StringToDate extension 구성
//        scrapedNews.pubDate
//        monthDayLabel.text =
//        yearLabel.text =
        titleLabel.text = scrapedNews.title?.htmlToString
        descriptionLabel.text = scrapedNews.desc?.htmlToString
    }
}

private extension NewsScrapViewCell {
    func setupLayout() {
        [colorBlock, reportStackView].forEach {
            contentView.addSubview($0)
        }
        
        colorBlock.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(100.0)
        }
        
        dateStackView.snp.makeConstraints {
            $0.edges.equalTo(colorBlock.snp.edges).inset(16.0)
        }
        
        reportStackView.snp.makeConstraints {
            $0.centerY.equalTo(colorBlock.snp.centerY)
            $0.leading.equalTo(colorBlock.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
    }
}
    
