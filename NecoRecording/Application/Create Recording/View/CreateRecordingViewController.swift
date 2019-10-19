//
//  CreateRecordingViewController.swift
//  NecoRecording
//
//  Created by MAC on 19/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import UIKit

final class CreateRecordingViewController: BaseViewController {
    
    // MARK: - Views -
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    // MARK: - Attributes -
    private let viewModel: CreateRecordingViewModelType

    // MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Recording"
        
        notifyViewModel()
        observeViewModelEvents()
    }
    
    // MARK: - Init -
    init(viewModel: CreateRecordingViewModelType = CreateRecordingViewModel()) {
        self.viewModel = viewModel
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Utils -
    private func notifyViewModel() {
        titleTextField.rx.text.map({ $0 ?? "" })
            .bind(to: viewModel.recordingTitle)
            .disposed(by: disposeBag)
    }
    
    private func observeViewModelEvents() {
        viewModel.recordingTitle.asDriver()
            .drive(onNext: { [weak self] (text: String) in
                self?.titleTextField.text = text
            })
            .disposed(by: disposeBag)
        
        viewModel.isRecording.asDriver()
            .drive(onNext: { [weak self] (isRecording: Bool) in
                self?.actionButton.setTitle(
                    isRecording
                        ? String.Constant.recordButtonRecordingTitle.value
                        : String.Constant.recordButtonNonRecordingTitle.value,
                    for: .normal
                )
                UIView.animate(withDuration: 0.25) {
                    self?.actionButton.backgroundColor = isRecording
                        ? UIColor.Constant.red.value
                        : UIColor.Constant.blue.value
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Actions -
    @IBAction func actionButtonPressed() {
        viewModel.isRecording.value
            ? viewModel.finishRecording()
            : viewModel.startRecording()
    }
    
}
