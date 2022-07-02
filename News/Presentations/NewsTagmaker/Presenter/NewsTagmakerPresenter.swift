//
//  NewsTagmakerPresenter.swift
//  News
//
//  Created by Sang hun Lee on 2022/06/30.
//

import UIKit

protocol NewsTagmakerProtocol: AnyObject {
    func setupNavigationBar()
    func setupLayout()
    func reloadCollectionView()
    func dismissToNewListViewController()
    func showToast(with message: String)
    func endEditing()
}

protocol NewsTagmakerDelegate {
    func makeTags(_ tags: [String])
}

final class NewsTagmakerPresenter: NSObject {
    private weak var viewController: NewsTagmakerProtocol?
    private let delegate: NewsTagmakerDelegate
    
    var tags: [String]
    private var keyword: String = ""
    
    init(
        viewController: NewsTagmakerProtocol,
        delegate: NewsTagmakerDelegate,
        tags: [String]
    ) {
        self.viewController = viewController
        self.delegate = delegate
        self.tags = tags
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupLayout()
    }
    
    func setTags() {
        guard keyword != "" else { return }
        if tags.contains(keyword) {
            viewController?.showToast(with: "이미 추가된 태그입니다")
        } else {
            tags.insert(keyword, at: 0)
            viewController?.reloadCollectionView()
            viewController?.endEditing()
        }
    }
    
    func didTapRightBarButton() {
        setTags()
    }
    
    func didTapAdjustButton() {
        delegate.makeTags(tags)
        viewController?.dismissToNewListViewController()
    }
    
    func dismissKeyboard() {
        viewController?.endEditing()
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tags = tags.filter { $0 != tags[indexPath.item] }
        viewController?.reloadCollectionView()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        viewController?.endEditing()
        keyword = ""
    }
}

extension NewsTagmakerPresenter: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        keyword = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        setTags()
    }
}
