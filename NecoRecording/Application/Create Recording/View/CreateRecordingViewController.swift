//
//  CreateRecordingViewController.swift
//  NecoRecording
//
//  Created by MAC on 19/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import UIKit

final class CreateRecordingViewController: BaseViewController {
    
    // MARK: - Attributes -
    private let viewModel: CreateRecordingViewModelType

    // MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Recording"
    }
    
    // MARK: - Init -
    init(viewModel: CreateRecordingViewModelType = CreateRecordingViewModel()) {
        self.viewModel = viewModel
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
