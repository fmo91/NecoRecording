//
//  RecordingItemViewModel.swift
//  NecoRecording
//
//  Created by Fernando Martín Ortiz on 15/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import Foundation

struct RecordingItemViewModel {
    let title: String
    let subtitle: String
    let identifier = UUID()
    
    init(recording: Recording) {
        self.title = recording.name
        self.subtitle = recording.duration.description
    }
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}

extension RecordingItemViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
