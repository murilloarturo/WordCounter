//
//  SpeechPresenter.swift
//  WordCounter
//
//  Created by Arturo on 1/11/18.
//  Copyright © 2018 Arturo. All rights reserved.
//

import Foundation
import RxSwift

class SpeechPresenter {
    private let interactor: SpeechInteractor
    private let router: SpeechRouter
    private let dataSource: SpeechesDataSource
    
    init(interactor: SpeechInteractor, router: SpeechRouter) {
        self.interactor = interactor
        self.router = router
        self.dataSource = SpeechesDataSource()
        
        dataSource.delegate = self
        router.showSpeechs(with: self, dataSource: dataSource)
    }
}

extension SpeechPresenter: SpeechesViewControllerPresenter {
    func loadSpeeches() -> Observable<[Speech]> {
        return interactor.speeches()
    }
}

extension SpeechPresenter: SpeechesDataSourceDelegate {
    func didSelectSpeech(_ speech: Speech) {
        router.showSpeechDetail(speech.text, orator: speech.orator, presenter: self)
    }
}

extension SpeechPresenter: SpeechDetailViewControllerPresenter {
    func progress() -> Observable<Float> {
        return interactor.progress()
    }
    
    func mostUsedWord(from speech: String) -> Observable<String> {
        return interactor.mostFrequentWord(from: speech)
    }
}
