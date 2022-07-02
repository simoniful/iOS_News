//
//  MockNewsTagmakerViewController.swift
//  NewsTests
//
//  Created by Sang hun Lee on 2022/07/02.
//

import Foundation
@testable import News

final class MockNewsTagmakerViewController: NewsTagmakerProtocol {
    var isCalledSetupNavigationBar = false
    var isCalledSetupLayout = false
    var isCalledReloadCollectionView = false
    var isCalledDismissToNewListViewController = false
    var isCalledShowToast = false
    var isCalledEndEditing = false
    
    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }
    
    func setupLayout() {
        isCalledSetupLayout = true
    }
    
    func reloadCollectionView() {
        isCalledReloadCollectionView = true
    }
    
    func dismissToNewListViewController() {
        isCalledDismissToNewListViewController = true
    }
    
    func showToast(with message: String) {
        isCalledShowToast = true
    }
    
    func endEditing() {
        isCalledEndEditing = true
    }
}
