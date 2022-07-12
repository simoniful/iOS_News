//
//  NewsTagmakerViewModel.swift
//  News
//
//  Created by Sang hun Lee on 2022/07/11.
//

import Foundation
import RxSwift
import RxCocoa

protocol NewsTagmakerDelegate {
    func makeTags(_ tags: [String])
}

final class NewsTagmakerViewModel: NSObject, ViewModel {
    var disposeBag = DisposeBag()
    
    weak var coordinator: NewsListCoordinator?
    private let newsTagmakerDelegate: NewsTagmakerDelegate
    
    var keyword: String = ""
    
    init(
        coordinator: NewsListCoordinator,
        newsTagmakerDelegate: NewsTagmakerDelegate,
        tags: [String]
    ) {
        self.coordinator = coordinator
        self.newsTagmakerDelegate = newsTagmakerDelegate
        self.tags.accept(tags)
    }
    
    struct Input {
        let didSelectItemAt: Signal<IndexPath>
        let searchBarText: Signal<String>
        let searchBarSearchButtonTapped: Signal<Void>
        let rightBarButtonTapped: Signal<Void>
        let adjustButtonTapped: Signal<Void>
        let willBeginDragging: Signal<Void>
    }
    
    struct Output {
        let tags: Driver<[String]>
        let showToastAction: Signal<String>
        let endEditing: Signal<Void>
    }
    
    let tags = BehaviorRelay<[String]>(value: [])
    let showToastAction = PublishRelay<String>()
    let endEditing = PublishRelay<Void>()
    
    func transform(input: Input) -> Output {
        input.searchBarText
            .emit(onNext: { [weak self] string in
                guard let self = self else { return }
                let limitTextCount = 15
                if string.count < limitTextCount {
                    self.keyword = string
                } else {
                    self.endEditing.accept(())
                    self.showToastAction.accept(ToastCase.stringCountOver.description)
                }
            })
            .disposed(by: disposeBag)
        
        input.didSelectItemAt
            .emit(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                let deleteOne = self.tags.value[indexPath.row]
                let newValue = self.tags.value.filter { $0 != deleteOne }
                self.tags.accept(newValue)
            })
            .disposed(by: disposeBag)
        
        Observable<Void>.merge(
            input.searchBarSearchButtonTapped.asObservable(),
            input.rightBarButtonTapped.asObservable()
        )
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.setTags()
            })
            .disposed(by: disposeBag)
            
        input.adjustButtonTapped
            .emit(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.newsTagmakerDelegate.makeTags(self.tags.value)
                self.coordinator?.dismissToNewsListViewController(message: ToastCase.tagsSettingCompleted.description)
            })
            .disposed(by: disposeBag)
        
        input.willBeginDragging
            .emit(onNext: { [weak self] _ in
                self?.endEditing.accept(())
            })
            .disposed(by: disposeBag)
        
        return Output(
            tags: tags.asDriver(),
            showToastAction: showToastAction.asSignal(),
            endEditing: endEditing.asSignal()
        )
    }
}

private extension NewsTagmakerViewModel {
    func setTags() {
        if tags.value.contains(keyword) {
            self.showToastAction.accept(ToastCase.tagContained.description)
        } else {
            guard !keyword.isBlank else {
                self.showToastAction.accept(ToastCase.blankTextInput.description)
                return
            }
            var newValue = self.tags.value
            newValue.insert(keyword, at: 0)
            tags.accept(newValue)
            endEditing.accept(())
        }
    }
}
