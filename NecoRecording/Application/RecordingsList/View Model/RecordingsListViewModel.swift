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
    var items: BehaviorRelay<[RecordingItemViewModel]> { get }
    var isLoadingItems: Driver<Bool> { get }
    
    func reload()
    func createRecordingViewModel(for item: RecordingItemViewModel) -> PlayRecordingViewModelType
}

final class RecordingsListViewModel: RecordingsListViewModelType {
    // MARK: - Internal State -
    private let repository: RecordingsRepositoryType
    private let recordings = BehaviorRelay<[Recording]>(value: [])
    private let isLoadingItemsRelay = BehaviorRelay<Bool>(value: false)
    private let errorMessageRelay = BehaviorRelay<String?>(value: nil)
    private let disposeBag = DisposeBag()
    
    // MARK: - Public reactive state -
    private(set) lazy var items = BehaviorRelay<[RecordingItemViewModel]>(value: [])
    private(set) lazy var isLoadingItems: Driver<Bool> = isLoadingItemsRelay.asDriver()
    private(set) lazy var errorMessage: Driver<String> = errorMessageRelay.asObservable()
        .filter({ $0 != nil })
        .map({ $0! })
        .asDriver(onErrorJustReturn: "")
    
    // MARK: - Init -
    init(repository: RecordingsRepositoryType = RecordingsRepository()) {
        self.repository = repository
    }
    
    // MARK: - Protocol Requirements -
    func reload() {
        self.isLoadingItemsRelay.accept(true)
        repository.getRecordings()
            .do(
                onSuccess: { [weak self] (recordings: [Recording]) in
                    self?.recordings.accept(recordings)
                    self?.isLoadingItemsRelay.accept(false)
                },
                onError: { [weak self] (_) in
                    self?.isLoadingItemsRelay.accept(false)
                }
            )
            .map({ $0.map(RecordingItemViewModel.init) })
            .subscribe(
                onSuccess: { [weak self] (items: [RecordingItemViewModel]) in
                    self?.items.accept(items)
                },
                onError: { [weak self] (error: Error) in
                    guard let self = self else { return }
                    let message = self.message(forFetchingError: error)
                    self.errorMessageRelay.accept(message)
                }
            )
            .disposed(by: disposeBag)
    }
    
    func createRecordingViewModel(for item: RecordingItemViewModel) -> PlayRecordingViewModelType {
        let recording = self.recordings.value.recording(for: item)!
        return PlayRecordingViewModel(recording: recording)
    }
    
    // MARK: - Utils -
    private func message(forFetchingError fetchingError: Error) -> String {
        return String.Constant.defaultError.value
    }
}

private extension Array where Element == Recording {
    func recording(for item: RecordingItemViewModel) -> Recording? {
        return first { (recording) -> Bool in
            return recording.id == item.id
        }
    }
}

final class MockRecordingsListViewModel: RecordingsListViewModelType {
    var isLoadingItemsRelay = BehaviorRelay<Bool>(value: false)
    
    let items = BehaviorRelay<[RecordingItemViewModel]>(value: [])
    lazy var isLoadingItems: Driver<Bool> = isLoadingItemsRelay.asDriver()
    
    func reload() {
        items.accept(items.value)
    }
    
    func createRecordingViewModel(for item: RecordingItemViewModel) -> PlayRecordingViewModelType {
        fatalError()
    }
}
