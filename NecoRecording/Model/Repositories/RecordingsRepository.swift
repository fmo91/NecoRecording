//
//  RecordingsRepository.swift
//  NecoRecording
//
//  Created by Fernando Martín Ortiz on 16/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import RxSwift
import RxCocoa

protocol RecordingsRepositoryType {
    func getRecordings() -> Single<[Recording]>
    func getRecordingDetail(id: Int) -> Single<Recording>
}

struct RecordingsRepository: RecordingsRepositoryType {
    func getRecordings() -> Single<[Recording]> {
        return .error(GeneralError.unimplemented)
    }
    func getRecordingDetail(id: Int) -> Single<Recording> {
        return .error(GeneralError.unimplemented)
    }
}

struct MockRecordingsRepository: RecordingsRepositoryType {
    var getRecordingMockResponse: [Recording]?
    var getRecordingDetailMockResponse: Recording?
    
    func getRecordings() -> Single<[Recording]> {
        if let response = getRecordingMockResponse {
            return .just(response)
        } else {
            return .error(GeneralError.unknown)
        }
    }
    
    func getRecordingDetail(id: Int) -> Single<Recording> {
        if let response = getRecordingDetailMockResponse {
            return .just(response)
        } else {
            return .error(GeneralError.unknown)
        }
    }
}
