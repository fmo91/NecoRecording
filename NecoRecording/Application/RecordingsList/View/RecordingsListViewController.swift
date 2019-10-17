//
//  RecordingsListViewController.swift
//  NecoRecording
//
//  Created by Fernando Martín Ortiz on 14/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import UIKit

final class RecordingsListViewController: BaseViewController {
    
    // MARK: - Views -
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Attributes -
    private let viewModel: RecordingsListViewModelType
    
    // MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
    
    // MARK: - Init -
    init(viewModel: RecordingsListViewModelType = RecordingsListViewModel()) {
        self.viewModel = viewModel
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
