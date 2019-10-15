//
//  InitialViewController.swift
//  NecoRecording
//
//  Created by Fernando Martín Ortiz on 14/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import UIKit

/// 
final class InitialViewController: BaseViewController {

    // MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        transitionToHome()
    }
    
    // MARK: - Utils -
    private func transitionToHome() {
        let rootViewController = RecordingsListViewController()
        let navigationController = BaseNavigationController(rootViewController: rootViewController)
        NavigationHelper.setRoot(viewController: navigationController, animated: true)
    }

}

