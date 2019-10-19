//
//  CreateRecordingViewControllerTests.swift
//  NecoRecordingTests
//
//  Created by MAC on 19/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import XCTest
@testable import NecoRecording

final class CreateRecordingViewControllerTests: XCTestCase {
    func testViewControllerConfigurationOnButtonPress() {
        let viewModel = MockCreateRecordingViewModel()
        let viewController = CreateRecordingViewController(viewModel: viewModel)
        viewController.actionButtonPressed()
        XCTAssertEqual(viewModel.numberOfCallsToStartRecording, 1)
        viewModel.isRecording.accept(true)
        viewController.actionButtonPressed()
        XCTAssertEqual(viewModel.numberOfCallsToFinishRecording, 1)
    }
}
