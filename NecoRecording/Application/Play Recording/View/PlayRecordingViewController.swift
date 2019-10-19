//
//  PlayRecordingViewController.swift
//  NecoRecording
//
//  Created by MAC on 19/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import UIKit

final class PlayRecordingViewController: BaseViewController {
    
    // MARK: - Attributes -
    private let viewModel: PlayRecordingViewModelType

    // MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Init -
    init(viewModel: PlayRecordingViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
