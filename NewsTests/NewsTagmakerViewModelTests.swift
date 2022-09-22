//
//  NewsTagmakerViewModelTests.swift
//  NewsTests
//
//  Created by Sang hun Lee on 2022/07/14.
//

import XCTest
import RxSwift
import RxTest

@testable import News

final class NewsTagmakerViewModelTests: XCTestCase {
    private var disposeBag: DisposeBag!
    private var scheduler: TestScheduler!
    private var input: NewsTagmakerViewModel.Input!
    private var output: NewsTagmakerViewModel.Output!
    
    private var tagmakerViewModel: NewsTagmakerViewModel!
    private var newListViewModel: NewsListViewModel!
    private var newsSearchManager = MockNewsSearchManager()
    private var searchUseCase: SearchUseCase!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        searchUseCase = SearchUseCase(repository: newsSearchManager)
        
        newListViewModel = NewsListViewModel(
            coordinator: nil,
            searchUseCase: searchUseCase
        )
    
        tagmakerViewModel = NewsTagmakerViewModel(
            coordinator: nil,
            newsTagmakerDelegate: newListViewModel,
            tags: ["IT", "개발", "iOS", "WWDC", "Apple"]
        )
    }
    
    override func tearDown() {
        tagmakerViewModel = nil
        newListViewModel = nil
        searchUseCase = nil
        scheduler = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func test_입력_후_버튼_동작_및_태그_선택_시_삭제_성공한다면() {
        let didSelectItemAtEvent = scheduler.createHotObservable([
            .next(3, IndexPath(row: 5, section: 0))
        ])
        
        let searchBarTextEvent = scheduler.createHotObservable([
            .next(0, "아이폰")
        ])
        
        let searchBarSearchButtonTappedEvent = scheduler.createHotObservable([
            .next(1, ())
        ])
        
        let rightBarButtonTappedEvent = scheduler.createHotObservable([
            .next(2, ())
        ])
        
        let adjustButtonTappedEvent = scheduler.createHotObservable([
            .next(5, ())
        ])
        
        let willBeginDraggingEvent = scheduler.createHotObservable([
            .next(4, ())
        ])
        
        let tagsObserver = self.scheduler.createObserver([String].self)
        
        input = NewsTagmakerViewModel.Input(
            didSelectItemAt: didSelectItemAtEvent.asSignal(onErrorJustReturn:  IndexPath(row: 5, section: 0)),
            searchBarText: searchBarTextEvent.asSignal(onErrorJustReturn: "아이폰"),
            searchBarSearchButtonTapped: searchBarSearchButtonTappedEvent.asSignal(onErrorJustReturn: ()),
            rightBarButtonTapped: rightBarButtonTappedEvent.asSignal(onErrorJustReturn: ()),
            adjustButtonTapped: adjustButtonTappedEvent.asSignal(onErrorJustReturn: ()),
            willBeginDragging: willBeginDraggingEvent.asSignal(onErrorJustReturn: ())
        )
        
        output = tagmakerViewModel.transform(input: input)
        
        output.tags
            .drive(tagsObserver)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(tagsObserver.events, [
            .next(0, ["IT", "개발", "iOS", "WWDC", "Apple"]),
            .next(1, ["아이폰", "IT", "개발", "iOS", "WWDC", "Apple"]),
            .next(3, ["아이폰", "IT", "개발", "iOS", "WWDC"])
        ], "입력 후 버튼 동작 및 태그 선택 시 삭제 성공")
    }
    

}
