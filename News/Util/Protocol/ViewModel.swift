//
//  ViewModel.swift
//  News
//
//  Created by Sang hun Lee on 2022/07/08.
//

import Foundation
import RxCocoa
import RxSwift

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
    var disposeBag: DisposeBag { get set }
}
