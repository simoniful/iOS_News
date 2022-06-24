//
//  NewsListViewHeader.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/24.
//

import UIKit
import TTGTags
import SnapKit

final class NewsListViewHeader: UITableViewHeaderFooterView {
    static let identifier = "NewsListViewHeader"
    
    private var tags: [String] = ["IT", "주식", "개발", "코로나", "게임", "부동산", "메타버스"]
    
    private lazy var tagCollectionView = TTGTextTagCollectionView()
    
    func setup() {
        setupLayout()
        setupTagCollectionView()
    }
}

extension NewsListViewHeader: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTap tag: TTGTextTag!, at index: UInt) {
        guard tag.selected else { return }
        print(tags[Int(index)])
    }
}

private extension NewsListViewHeader {
    func setupLayout() {
        addSubview(tagCollectionView)
        
        tagCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
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
