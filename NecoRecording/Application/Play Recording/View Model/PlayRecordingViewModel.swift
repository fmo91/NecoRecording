//
//  PlayRecordingViewModel.swift
//  NecoRecording
//
//  Created by MAC on 19/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import RxSwift
import RxCocoa

protocol PlayRecordingViewModelType {
    
}

final class PlayRecordingViewModel: PlayRecordingViewModelType {
    // MARK: - Attributes -
    private let recording: Recording
    
    // MARK: - Init -
    init(recording: Recording) {
        self.recording = recording
    }
}

final class MockPlayRecordingViewModel: PlayRecordingViewModelType {
    
}
