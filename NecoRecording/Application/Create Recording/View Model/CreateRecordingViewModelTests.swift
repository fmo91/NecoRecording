//
//  CreateRecordingViewModelTests.swift
//  NecoRecordingTests
//
//  Created by MAC on 19/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import XCTest
@testable import NecoRecording

final class CreateRecordingViewModelTests: XCTestCase {
    func testRecordingStateOnEvents() {
        let repository = MockRecordingsRepository()
        let viewModel = CreateRecordingViewModel(repository: repository)
     
        XCTAssertFalse(viewModel.isRecording.value)
        viewModel.startRecording()
        XCTAssertTrue(viewModel.isRecording.value)
        viewModel.finishRecording()
        XCTAssertFalse(viewModel.isRecording.value)
    }
}
