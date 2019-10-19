//
//  Recording.swift
//  NecoRecording
//
//  Created by MAC on 18/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import Foundation

struct Recording {
    let id: Int
    let name: String
    let duration: Int
    let content: Data?
    let attachments: [Attachment]?
}
