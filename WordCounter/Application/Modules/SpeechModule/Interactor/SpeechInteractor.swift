//
//  SpeechInteractor.swift
//  WordCounter
//
//  Created by Arturo on 1/11/18.
//  Copyright © 2018 Arturo. All rights reserved.
//

import Foundation
import RxSwift

class SpeechInteractor {
    private let disposeBag = DisposeBag()
    private let speechArray = Variable<[Speech]>([])
    
    init() {
        bind()
    }
    
    func speeches() -> Observable<[Speech]> {
        return speechArray.asObservable()
    }
}

private extension SpeechInteractor {
    func bind() {
        SpeechAPI().loadData()
            .subscribe(onNext: { [weak self] (data) in
                self?.speechArray.value = data
            })
            .disposed(by: disposeBag)
    }
}
