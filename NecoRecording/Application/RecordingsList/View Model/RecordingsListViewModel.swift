//
//  RecordingsListViewModel.swift
//  NecoRecording
//
//  Created by Fernando Martín Ortiz on 14/10/2019.
//  Copyright © 2019 Fernando Martín Ortiz. All rights reserved.
//

import RxSwift
import RxCocoa

protocol RecordingsListViewModelType {
    var items: Driver<[RecordingItemViewModel]> { get }
}

final class RecordingsListViewModel: RecordingsListViewModelType {
    let items: Driver<[RecordingItemViewModel]>
    
    init() {
        items = Observable<[RecordingItemViewModel]>
            .just([RecordingItemViewModel(title: "Prueba 1", subtitle: "40:20")])
            .asDriver(onErrorJustReturn: [])
    }
}
