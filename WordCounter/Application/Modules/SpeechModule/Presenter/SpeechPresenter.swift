//
//  SpeechPresenter.swift
//  WordCounter
//
//  Created by Arturo on 1/11/18.
//  Copyright © 2018 Arturo. All rights reserved.
//

import Foundation

protocol SpeechPresenterInterface {
    
}

class SpeechPresenter {
    private let interactor: SpeechInteractor
    private let router: SpeechRouter
    
    init(interactor: SpeechInteractor, router: SpeechRouter) {
        self.interactor = interactor
        self.router = router
        
        self.router.showSpeechs(with: self)
    }
}

extension SpeechPresenter: SpeechsViewControllerPresenter {
    
}
