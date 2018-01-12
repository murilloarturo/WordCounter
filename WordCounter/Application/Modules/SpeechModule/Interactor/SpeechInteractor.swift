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
    private let speechAPI = SpeechAPI()
    
    init() {
        bind()
    }
    
    func speeches() -> Observable<[Speech]> {
        return speechArray.asObservable()
    }
    
    func mostFrequentWord(from text: String) -> Observable<String> {
        return speechAPI.findMostFrequentWord(from: text).observeOn(MainScheduler.instance).asObservable()
    }
    
    func progress() -> Observable<Float> {
        return speechAPI.getProgress().observeOn(MainScheduler.instance)
    }
}

private extension SpeechInteractor {
    func bind() {
        speechAPI.loadData()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (data) in
                self?.speechArray.value = data
            })
            .disposed(by: disposeBag)
    }
}
