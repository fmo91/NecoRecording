//
//  RecordingItemViewModel.swift
//  NecoRecording
//
//  Created by Fernando Martín Ortiz on 15/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import Foundation

struct RecordingItemViewModel {
    let id: Int
    let title: String
    let subtitle: String
    
    init(recording: Recording) {
        self.id = recording.id
        self.title = recording.name
        self.subtitle = recording.duration.description
    }
    
    init(title: String, subtitle: String) {
        self.id = -1
        self.title = title
        self.subtitle = subtitle
    }
}
