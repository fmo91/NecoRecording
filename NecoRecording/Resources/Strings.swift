//
//  Strings.swift
//  NecoRecording
//
//  Created by MAC on 19/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import Foundation

extension String {
    enum Constant: String {
        case defaultError
        
        var value: String {
            NSLocalizedString(self.rawValue, comment: "")
        }
    }
}
