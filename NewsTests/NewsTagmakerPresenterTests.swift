//
//  NewsTagmakerPresenterTests.swift
//  NewsTests
//
//  Created by Sang hun Lee on 2022/07/02.
//

import XCTest
@testable import News

class NewsTagmakerPresenterTests: XCTestCase {
//    var sut: NewsTagmakerPresenter!
//    var viewController: MockNewsTagmakerViewController!
//    var delegate: MockNewsListViewController!
//    var tags: [String]!
//    
//    override func setUp() {
//        super.setUp()
//        
//        viewController = MockNewsTagmakerViewController()
//        delegate = MockNewsListViewController()
//        tags = ["IT", "주식", "개발", "코로나", "게임", "부동산", "메타버스"]
//        
//        sut = NewsTagmakerPresenter(
//            viewController: viewController,
//            delegate: delegate,
//            tags: tags
//        )
//    }
//    
//    override func tearDown() {
//        sut = nil
//        tags = nil
//        delegate = nil
//        viewController = nil
//        
//        super.tearDown()
//    }
//    
//    func test_viewDidLoad가_요청될_때() {
//        sut.viewDidLoad()
//        
//        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
//        XCTAssertTrue(viewController.isCalledSetupLayout)
//    }
//    
//    func test_setTags가_요청될_때_keyword가_이미_있는_경우() {
//        sut.keyword = "IT"
//        sut.setTags()
//        
//        XCTAssertTrue(viewController.isCalledShowToast)
//    }
//    
//    func test_setTags가_요청될_때_keyword가_새로운_경우() {
//        sut.keyword = "iOS"
//        sut.setTags()
//        
//        XCTAssertTrue(viewController.isCalledReloadCollectionView)
//        XCTAssertTrue(viewController.isCalledEndEditing)
//    }
//    
//    func test_didTapAdjustButton가_요청될_때() {
//        sut.didTapAdjustButton()
//        
//        XCTAssertTrue(delegate.isCalledMakeTags)
//        XCTAssertTrue(viewController.isCalledDismissToNewListViewController)
//    }
//    
//    func test_dismissKeyboard가_요청될_때() {
//        sut.dismissKeyboard()
//        
//        XCTAssertTrue(viewController.isCalledEndEditing)
//    }
//    
//    func test_Collection에서_didSelectItemAt가_요청될_때() {
//        sut.collectionView(
//            UICollectionView(
//                frame: .zero,
//                collectionViewLayout: UICollectionViewLayout()
//            ),
//            didSelectItemAt: IndexPath(row: 0, section: 0)
//        )
//        
//        XCTAssertTrue(viewController.isCalledReloadCollectionView)
//    }
//    
//    func test_Collection에서_scrollViewWillBeginDragging가_요청될_때() {
//        sut.scrollViewWillBeginDragging(
//            UICollectionView(
//                frame: .zero,
//                collectionViewLayout: UICollectionViewLayout()
//            )
//        )
//        
//        XCTAssertTrue(viewController.isCalledEndEditing)
//    }
//    
//    func test_searchBarSearchButtonClicked가_요청될_때() {
//        sut.keyword = "iOS"
//        sut.searchBarSearchButtonClicked(UISearchBar())
//        
//        XCTAssertTrue(viewController.isCalledReloadCollectionView)
//        XCTAssertTrue(viewController.isCalledEndEditing)
//    }
}
