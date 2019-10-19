//
//  Colors.swift
//  NecoRecording
//
//  Created by MAC on 19/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import UIKit

extension UIColor {
    enum Constant: String {
        case red = "Red"
        case blue = "Blue"
        
        var value: UIColor {
            UIColor(named: self.rawValue) ?? .clear
        }
    }
}
