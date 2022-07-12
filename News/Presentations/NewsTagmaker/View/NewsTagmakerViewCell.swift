//
//  NewsTagmakerViewCell.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/30.
//

import UIKit
import SnapKit

final class NewsTagmakerViewCell: UICollectionViewCell {
    static let identifier = "NewsTagmakerViewCell"
    
    private lazy var tagButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .semibold)
        button.setTitleColor(UIColor.systemOrange, for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemOrange.cgColor
        contentView.layer.cornerRadius = 12.0
        contentView.clipsToBounds = true
    }
    
    func setup(tag: String) {
        setupView()
        setupConstraints()
        tagButton.setTitle(tag, for: .normal)
        layoutIfNeeded()
    }
}

extension NewsTagmakerViewCell: ViewRepresentable {
    func setupView() {
        contentView.addSubview(tagButton)
    }
    
    func setupConstraints() {
        tagButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(8.0)
            $0.trailing.equalToSuperview().inset(8.0)
        }
    }
}
