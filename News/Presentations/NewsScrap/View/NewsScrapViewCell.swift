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
        stackView.spacing = 6.0
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
        label.font = .systemFont(ofSize: 13.0, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "오전 05:03"
        label.font = .systemFont(ofSize: 10.0, weight: .semibold)
        label.textColor = .white
        return label
    }()
     
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.text = "2022"
        label.font = .systemFont(ofSize: 10.0, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        [monthDayLabel, timeLabel, yearLabel].forEach {
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
        setupView()
        setupConstraints()
        
        selectionStyle = .none
        
        let date = scrapedNews.pubDate?.toDate()
        let year = date?.toString(pattern: .year)
        let monthDay = date?.toString(pattern: .date)
        let time = date?.toString(pattern: .time)
    
        monthDayLabel.text = monthDay
        yearLabel.text = year
        timeLabel.text = time
        titleLabel.text = scrapedNews.title
        descriptionLabel.text = scrapedNews.desc
    }
}

extension NewsScrapViewCell: ViewRepresentable {
    func setupView() {
        [colorBlock, reportStackView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        colorBlock.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.greaterThanOrEqualTo(90.0)
        }
        
        dateStackView.snp.makeConstraints {
            $0.edges.equalTo(colorBlock.snp.edges).inset(12.0)
        }
        
        reportStackView.snp.makeConstraints {
            $0.centerY.equalTo(colorBlock.snp.centerY)
            $0.leading.equalTo(colorBlock.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
    }
}
    
