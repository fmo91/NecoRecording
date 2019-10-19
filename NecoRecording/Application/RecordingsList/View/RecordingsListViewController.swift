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
    enum Section: CaseIterable {
        case recordings
    }
    
    // MARK: - Views -
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Attributes -
    private let viewModel: RecordingsListViewModelType
    private var dataSource: UITableViewDiffableDataSource<Section, RecordingItemViewModel>?
    
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
        tableView.register(UINib(nibName: RecordingsListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RecordingsListTableViewCell.identifier)
        
        dataSource = UITableViewDiffableDataSource<Section, RecordingItemViewModel>(tableView: tableView) { (tableView: UITableView, indexPath: IndexPath, item: RecordingItemViewModel) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: RecordingsListTableViewCell.identifier) as! RecordingsListTableViewCell
            cell.configure(for: item)
            return cell
        }
        
        tableView.delegate = self
    }
    
    private func observeViewModel() {
        viewModel.items.asDriver()
            .map { (items: [RecordingItemViewModel]) -> NSDiffableDataSourceSnapshot<Section, RecordingItemViewModel> in
                var snapshot = NSDiffableDataSourceSnapshot<Section, RecordingItemViewModel>()
                snapshot.appendSections([.recordings])
                snapshot.appendItems(items)
                return snapshot
            }
            .drive(onNext: { [weak self] (snapshot: NSDiffableDataSourceSnapshot<RecordingsListViewController.Section, RecordingItemViewModel>) in
                self?.dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
}

// MARK: - UITableViewDelegate -
extension RecordingsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RecordingsListTableViewCell.height
    }
}
