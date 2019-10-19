//
//  RecordingsListViewControllerTests.swift
//  NecoRecordingTests
//
//  Created by Fernando Martín Ortiz on 14/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import XCTest
@testable import NecoRecording

final class RecordingsListViewControllerTests: XCTestCase {

    func testTableViewFillsWithItems() {
        let viewModel = MockRecordingsListViewModel()
        let viewController = RecordingsListViewController(viewModel: viewModel)
        
        let items = [
            RecordingItemViewModel(title: "First title", subtitle: "First subtitle"),
            RecordingItemViewModel(title: "Second title", subtitle: "Second subtitle"),
            RecordingItemViewModel(title: "Third title", subtitle: "Third subtitle"),
        ]
        
        viewModel.items.accept(items)
        
        _ = viewController.view
        viewModel.reload()
        
        let numberOfRows = viewController.tableView.numberOfRows(inSection: RecordingsListViewController.Section.recordings.rawValue)
        
        XCTAssertEqual(items.count, numberOfRows)
    }
    
    func testTableViewFillsWithMultipleUpdates() {
        let viewModel = MockRecordingsListViewModel()
        let viewController = RecordingsListViewController(viewModel: viewModel)
        
        let items = [
            RecordingItemViewModel(title: "First title", subtitle: "First subtitle"),
            RecordingItemViewModel(title: "Second title", subtitle: "Second subtitle"),
            RecordingItemViewModel(title: "Third title", subtitle: "Third subtitle"),
        ]
        
        viewModel.items.accept(items)
        
        _ = viewController.view
        viewModel.reload()
        
        let numberOfRows = viewController.tableView.numberOfRows(inSection: RecordingsListViewController.Section.recordings.rawValue)
        
        XCTAssertEqual(items.count, numberOfRows)
        
        
        let itemsForUpdate = [
            RecordingItemViewModel(title: "Fourth title", subtitle: "Fourth subtitle"),
        ]
        
        viewModel.items.accept(itemsForUpdate)
        
        let numberOfRowsAfterUpdate = viewController.tableView.numberOfRows(inSection: RecordingsListViewController.Section.recordings.rawValue)
        
        XCTAssertEqual(itemsForUpdate.count, numberOfRowsAfterUpdate)
    }

}
