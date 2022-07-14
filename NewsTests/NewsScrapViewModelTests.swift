//
//  NewsScrapViewModelTests.swift
//  NewsTests
//
//  Created by Sang hun Lee on 2022/07/14.
//

import XCTest
import RxSwift
import RxTest

@testable import News

final class NewsScrapViewModelTests: XCTestCase {
    private var disposeBag: DisposeBag!
    private var scheduler: TestScheduler!
    private var input: NewsScrapViewModel.Input!
    private var output: NewsScrapViewModel.Output!

    private var viewModel: NewsScrapViewModel!
    private var coreDataManager =  MockCoreDataManager()
    private var dataBaseUseCase: DataBaseUseCase!
    
    private lazy var mockScraped = coreDataManager.fetchData(request: ScrapedNews.fetchRequest())
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        dataBaseUseCase = DataBaseUseCase(repository: coreDataManager)
        viewModel = NewsScrapViewModel(
            coordinator: nil,
            dataBaseUseCase: dataBaseUseCase
        )
        
        let mock = News(
            title: "\'토종\' 코로나 백신 나온다...원료~완제품 이달내 허가",
            originallink: "http://www.seouleconews.com/news/articleView.html?idxno=66852",
            link: "http://www.seouleconews.com/news/articleView.html?idxno=66852",
            desc: "SK바이오사이언스 GBP510  SK바이오사이언스의 \'국산 1호\' 코로나19 백신이 품목허가 절차중 최대 고비를 무사히 통과해 허가가 매우 유력해졌다. 마지막 점검절차만 남겨놓은 상태다. 이 제품은 최초의 국내 개발 코로나19... ",
            pubDate: "Mon, 27 Jun 2022 14:14:00 +0900",
            isScraped: false
        )

        Array(repeating: mock, count: 5).forEach {
            coreDataManager.saveNews(item: $0)
        }
    }
    
    override func tearDown() {
        coreDataManager.fetchData(request: ScrapedNews.fetchRequest()).forEach {
            coreDataManager.deleteNews(object: $0)
        }
        
        viewModel = nil
        dataBaseUseCase = nil
        scheduler = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func test_viewWillAppear시점_성공적으로_데이터가_불러와진다면_첫번째_데이터_삭제() {
        let didSelectRowAtEvent = scheduler.createHotObservable([
            .next(5, mockScraped.first!)
        ])
        
        let deleteForRowAtEvent = scheduler.createHotObservable([
            .next(10, IndexPath(row: 0, section: 0))
        ])
        
        let viewWillAppearEvent = scheduler.createHotObservable([
            .next(0, ())
        ])
        
        let scrapedNewsListObserver = self.scheduler.createObserver([ScrapedNews].self)
        
        input = NewsScrapViewModel.Input(
            didSelectRowAt: didSelectRowAtEvent.asSignal(onErrorJustReturn: mockScraped.first!),
            deleteForRowAt: deleteForRowAtEvent.asSignal(onErrorJustReturn: IndexPath(row: 0, section: 0)),
            viewWillAppear: viewWillAppearEvent.asSignal(onErrorJustReturn: ())
        )
        
        output = viewModel.transform(input: input)
        
        output.scrapedNewsList
            .drive(scrapedNewsListObserver)
            .disposed(by: disposeBag)
        
        let deletedMockScraped = Array(mockScraped.dropFirst())
        
        scheduler.start()
        
        XCTAssertEqual(scrapedNewsListObserver.events, [
            .next(0, []),
            .next(0, mockScraped),
            .next(10, deletedMockScraped)
        ], "화면이 나타날 때 데이터 패칭 및 삭제 성공")
    }
}
