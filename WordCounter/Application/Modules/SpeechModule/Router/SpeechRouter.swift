//
//  SpeechRouter.swift
//  WordCounter
//
//  Created by Arturo on 1/11/18.
//  Copyright © 2018 Arturo. All rights reserved.
//

import UIKit

class SpeechRouter {
    private let navigation: UINavigationController
    
    init() {
        self.navigation = UINavigationController()
    }
    
    func showSpeechs(with presenter: SpeechsViewControllerPresenter) {
        let viewController = SpeechsViewController(presenter: presenter)
        navigation.viewControllers = [viewController]
    }
    
    func setupApplicationWindow(_ window: UIWindow?) {
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
