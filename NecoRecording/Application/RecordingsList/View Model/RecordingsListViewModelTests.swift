//
//  RecordingsListViewModelTests.swift
//  NecoRecordingTests
//
//  Created by Fernando Martín Ortiz on 14/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import XCTest
@testable import NecoRecording
import RxSwift
import RxTest

final class RecordingsListViewModelTests: XCTestCase {
    
    var disposeBag = DisposeBag()

    func testOnEmptyState() {
        var repository = MockRecordingsRepository()
        repository.getRecordingMockResponse = []
        let viewModel = RecordingsListViewModel(repository: repository)
        
        let expectation = XCTestExpectation()
        viewModel.items.asObservable()
            .subscribe(onNext: { (items: [RecordingItemViewModel]) in
                XCTAssert(items.isEmpty)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 60)
    }
    
    func testStateContentsOnError() {
        let repository = MockRecordingsRepository()
        let viewModel = RecordingsListViewModel(repository: repository)
        viewModel.reload()
        let expectation = XCTestExpectation()
        viewModel.errorMessage.asObservable().subscribe(onNext: { (message: String) in
            XCTAssert(!message.isEmpty)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 60)
    }
    
    func testOnNormalState() {
        var repository = MockRecordingsRepository()
        repository.getRecordingMockResponse = [
            Recording(id: 1, name: "First Recording", duration: 6000, content: nil, attachments: nil)
        ]
        let viewModel = RecordingsListViewModel(repository: repository)
        viewModel.reload()
        let expectation = XCTestExpectation()
        viewModel.items.asObservable().subscribe(onNext: { (items: [RecordingItemViewModel]) in
            XCTAssertEqual(items.count, 1)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 60)
    }

}
