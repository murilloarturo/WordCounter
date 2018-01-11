//
//  SpeechRouter.swift
//  WordCounter
//
//  Created by Arturo on 1/11/18.
//  Copyright © 2018 Arturo. All rights reserved.
//

import UIKit

class SpeechRouter {
    let navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
        
        setup()
    }
}

private extension SpeechRouter {
    func setup() {
        navigation.viewControllers = [SpeechsViewController()]
    }
}
