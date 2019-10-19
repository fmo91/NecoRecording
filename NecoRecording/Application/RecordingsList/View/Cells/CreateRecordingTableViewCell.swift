//
//  CreateRecordingTableViewCell.swift
//  NecoRecording
//
//  Created by MAC on 19/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import UIKit

final class CreateRecordingTableViewCell: UITableViewCell {
    
    // MARK: - Constants -
    static let identifier = "CreateRecordingTableViewCell"

    // MARK: - Life Cycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    // MARK: - Size -
    static var height: CGFloat {
        return 55.0
    }

}
