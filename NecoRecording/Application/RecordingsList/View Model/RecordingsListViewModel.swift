//
//  RecordingsListViewModel.swift
//  NecoRecording
//
//  Created by Fernando Martín Ortiz on 14/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import RxSwift
import RxCocoa

protocol RecordingsListViewModelType {
    var items: Driver<[RecordingItemViewModel]> { get }
    var isLoadingItems: Driver<Bool> { get }
    
    init(repository: RecordingsRepositoryType)
}

final class RecordingsListViewModel: RecordingsListViewModelType {
    // MARK: - Internal State -
    private let repository: RecordingsRepositoryType
    private let _items = BehaviorRelay<[RecordingItemViewModel]>(value: [])
    private let _isLoadingItems = BehaviorRelay<Bool>(value: false)
    private let _errorMessage = BehaviorRelay<String?>(value: nil)
    private let disposeBag = DisposeBag()
    
    // MARK: - Public reactive state -
    private(set) lazy var items: Driver<[RecordingItemViewModel]> = _items.asDriver()
    private(set) lazy var isLoadingItems: Driver<Bool> = _isLoadingItems.asDriver()
    private(set) lazy var errorMessage: Driver<String> = _errorMessage.asObservable()
        .filter({ $0 != nil })
        .map({ $0! })
        .asDriver(onErrorJustReturn: "")
    
    // MARK: - Init -
    init(repository: RecordingsRepositoryType = RecordingsRepository()) {
        self.repository = repository
        
        self._isLoadingItems.accept(true)
        repository.getRecordings()
            .do(
                onSuccess: { [weak self] (_) in
                    self?._isLoadingItems.accept(false)
                },
                onError: { [weak self] (_) in
                    self?._isLoadingItems.accept(false)
                }
            )
            .map({ $0.map(RecordingItemViewModel.init) })
            .subscribe(
                onSuccess: { [weak self] (items: [RecordingItemViewModel]) in
                    self?._items.accept(items)
                },
                onError: { [weak self] (error: Error) in
                    guard let self = self else { return }
                    let message = self.message(forFetchingError: error)
                    self._errorMessage.accept(message)
                }
            )
            .disposed(by: disposeBag)
    }
    
    // MARK: - Utils -
    private func message(forFetchingError fetchingError: Error) -> String {
        return String.Constant.defaultError.value
    }
}
