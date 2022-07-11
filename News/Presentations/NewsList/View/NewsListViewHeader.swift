//
//  NewsListViewHeader.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/24.
//

import UIKit
import TTGTags
import SnapKit

protocol NewsListViewHeaderDelegate: AnyObject {
    func didSelectTag(_ selectedIndex: Int)
}

final class NewsListViewHeader: UITableViewHeaderFooterView {
    static let identifier = "NewsListViewHeader"
    
    private weak var delegate: NewsListViewHeaderDelegate?
    
    private var tags: [String] = []
    
    private lazy var tagCollectionView = TTGTextTagCollectionView()
    
    func setup(tags: [String], delegate: NewsListViewHeaderDelegate) {
        self.tags = tags
        self.delegate = delegate
        contentView.backgroundColor = .systemBackground
        setupView()
        setupConstraints()
        let prevTags = tagCollectionView.allTags().compactMap { tag in
            "\(tag.content)"
                .replacingOccurrences(
                    of: "<TTGTextTagStringContent: self.text=",
                    with: ""
                )
                .replacingOccurrences(
                    of: ">",
                    with: ""
                )
        }
        if prevTags != tags {
            tagCollectionView.removeAllTags()
            setupTagCollectionView()
        }
    }
}

extension NewsListViewHeader: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTap tag: TTGTextTag!, at index: UInt) {
        guard tag.selected else { return }
        delegate?.didSelectTag(Int(index))
    }
}

extension NewsListViewHeader: ViewRepresentable {
    func setupView() {
        addSubview(tagCollectionView)
    }
    
    func setupConstraints() {
        tagCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

private extension NewsListViewHeader {
    func setupTagCollectionView() {
        tagCollectionView.delegate = self
        
        let insetValue: CGFloat = 16.0
        let cornerRadiusValue: CGFloat = 12.0
        let shadowOpacityValue: CGFloat = 0.0
        let extraSpaceValue: CGSize = CGSize(width: 20.0, height: 12.0)
        let colorValue: UIColor = .systemOrange
        
        let style = TTGTextTagStyle()
        style.backgroundColor = colorValue
        style.cornerRadius = cornerRadiusValue
        style.borderWidth = 0.0
        style.shadowOpacity = shadowOpacityValue
        style.extraSpace = extraSpaceValue
        
        let selectedStyle = TTGTextTagStyle()
        selectedStyle.backgroundColor = .white
        selectedStyle.cornerRadius = cornerRadiusValue
        selectedStyle.borderColor = colorValue
        selectedStyle.shadowOpacity = shadowOpacityValue
        selectedStyle.extraSpace = extraSpaceValue
        
        tagCollectionView.numberOfLines = 1
        tagCollectionView.scrollDirection = .horizontal
        tagCollectionView.showsHorizontalScrollIndicator = false
        tagCollectionView.selectionLimit = 1
        
        tagCollectionView.contentInset = UIEdgeInsets(
            top: insetValue,
            left: insetValue,
            bottom: insetValue,
            right: insetValue
        )
        
        tags.forEach {
            let fontValue = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
            let tagContent = TTGTextTagStringContent(
                text: $0,
                textFont: fontValue,
                textColor: .white
            )
            
            let selectedTagContent = TTGTextTagStringContent(
                text: $0,
                textFont: fontValue,
                textColor: colorValue
            )
            
            let tag = TTGTextTag(
                content: tagContent,
                style: style,
                selectedContent: selectedTagContent,
                selectedStyle: selectedStyle
            )
            tagCollectionView.addTag(tag)
        }
    }
}
