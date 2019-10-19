//
//  RecordingsListViewController.swift
//  NecoRecording
//
//  Created by Fernando Martín Ortiz on 14/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import UIKit

final class RecordingsListViewController: BaseViewController {
    
    // MARK: - Inner Types -
    enum Section: Int, CaseIterable {
        case createRecording = 0
        case recordings
    }
    
    // MARK: - Views -
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Attributes -
    private let viewModel: RecordingsListViewModelType
    private var dataSource: UITableViewDiffableDataSource<Section, AnyHashable>?
    
    // MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Recordings"
        
        configureTableView()
        observeViewModel()
        
        viewModel.reload()
    }
    
    // MARK: - Init -
    init(viewModel: RecordingsListViewModelType = RecordingsListViewModel()) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration -
    private func configureTableView() {
        tableView.register(UINib(nibName: CreateRecordingTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CreateRecordingTableViewCell.identifier)
        tableView.register(UINib(nibName: RecordingsListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RecordingsListTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func observeViewModel() {
        viewModel.items.asDriver()
            .drive(onNext: { [weak self] (items: [RecordingItemViewModel]) in
                guard let self = self else { return }
                self.tableView.performBatchUpdates({
                    self.tableView.reloadSections(IndexSet.init(integer: Section.recordings.rawValue), with: .automatic)
                }, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
}

// MARK: - UITableViewDelegate -
extension RecordingsListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .createRecording:
            return 1
        case .recordings:
            return viewModel.items.value.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section(rawValue: indexPath.section)! {
        case .createRecording:
            let cell = tableView.dequeueReusableCell(withIdentifier: CreateRecordingTableViewCell.identifier) as! CreateRecordingTableViewCell
            return cell
        case .recordings:
            let cell = tableView.dequeueReusableCell(withIdentifier: RecordingsListTableViewCell.identifier) as! RecordingsListTableViewCell
            let recording = viewModel.items.value[indexPath.row]
            cell.configure(for: recording)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Section(rawValue: indexPath.section)! {
        case .createRecording: return CreateRecordingTableViewCell.height
        case .recordings: return RecordingsListTableViewCell.height
        }
    }
}
