//
//  ViewController.swift
//  NecoRecording
//
//  Created by Fernando Martín Ortiz on 14/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import UIKit
import RxSwift

open class BaseViewController: UIViewController {
    
    // MARK: - Attributes -
    let disposeBag = DisposeBag()

    // MARK: - Life Cycle -
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Init -
    init(nibName: String? = nil) {
        let name = String(describing: type(of: self))
        super.init(nibName: nibName ?? name, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

