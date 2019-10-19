//
//  RecordingsListTableViewCell.swift
//  NecoRecording
//
//  Created by MAC on 19/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import UIKit

final class RecordingsListTableViewCell: UITableViewCell {
    
    // MARK: - Views -
    @IBOutlet weak var recordingTitleLabel: UILabel!
    @IBOutlet weak var recordingSubtitleLabel: UILabel!
    
    // MARK: - Constants -
    static let identifier = "RecordingsListTableViewCell"

    // MARK: - Life Cycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    // MARK: - Configuration -
    func configure(for item: RecordingItemViewModel) {
        recordingTitleLabel.text = item.title
        recordingSubtitleLabel.text = item.subtitle
    }
    
    // MARK: - Size -
    static var height: CGFloat {
        return 55.0
    }
    
}
