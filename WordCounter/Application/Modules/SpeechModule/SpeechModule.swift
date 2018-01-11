//
//  SpeechModule.swift
//  WordCounter
//
//  Created by Arturo on 1/11/18.
//  Copyright © 2018 Arturo. All rights reserved.
//

import UIKit

class SpeechModule {
    private let presenter: SpeechPresenter
    private let router: SpeechRouter
    
    init() {
        let interactor = SpeechInteractor()
        router = SpeechRouter()
        presenter = SpeechPresenter(interactor: interactor, router: router)
    }
    
    func initalizeApplication(with window: UIWindow?) {
        router.setupApplicationWindow(window)
    }
}
