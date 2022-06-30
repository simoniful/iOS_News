//
//  NewsTagmakerPresenter.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/30.
//

import Foundation
import UIKit

protocol NewsTagmakerProtocol: AnyObject {
    func setupNavigationBar()
    func setupLayout()
}

final class NewsTagmakerPresenter: NSObject {
    private weak var viewController: NewsTagmakerProtocol?
    var tags: [String]
    
    init(
        viewController: NewsTagmakerProtocol,
        tags: [String]
    ) {
        self.viewController = viewController
        self.tags = tags
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupLayout()
    }
}

extension NewsTagmakerPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NewsTagmakerViewCell.identifier,
            for: indexPath
        ) as? NewsTagmakerViewCell else { return UICollectionViewCell() }
        cell.setup(tag: tags[indexPath.item])
        return cell
    }
}

extension NewsTagmakerPresenter: UICollectionViewDelegate {
    
}
