//
//  CreateRecordingViewModel.swift
//  NecoRecording
//
//  Created by MAC on 19/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import RxSwift
import RxCocoa

protocol CreateRecordingViewModelType {
    var recordingTitle: BehaviorRelay<String> { get }
    var isRecording: BehaviorRelay<Bool> { get }
    
    func startRecording()
    func finishRecording()
}

final class CreateRecordingViewModel: CreateRecordingViewModelType {
    private let repository: RecordingsRepositoryType
  
    let isRecording = BehaviorRelay<Bool>(value: false)
    let recordingTitle = BehaviorRelay<String>(value: "")
    
    init(repository: RecordingsRepositoryType = RecordingsRepository()) {
        self.repository = repository
    }
    
    func startRecording() {
        isRecording.accept(true)
    }
    func finishRecording() {
        isRecording.accept(false)
    }
}

final class MockCreateRecordingViewModel: CreateRecordingViewModelType {
    let recordingTitle = BehaviorRelay<String>(value: "")
    let isRecording = BehaviorRelay<Bool>(value: false)
    
    var numberOfCallsToStartRecording = 0
    var numberOfCallsToFinishRecording = 0
    
    func startRecording() {
        numberOfCallsToStartRecording += 1
    }
    func finishRecording() {
        numberOfCallsToFinishRecording += 1
    }
}
