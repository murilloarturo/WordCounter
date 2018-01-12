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
    
    func showSpeechs(with presenter: SpeechesViewControllerPresenter, dataSource: SpeechesDataSource) {
        let viewController = SpeechesViewController(presenter: presenter, dataSource: dataSource)
        navigation.viewControllers = [viewController]
    }
    
    func showSpeechDetail(_ speech: String, presenter: SpeechDetailViewControllerPresenter) {
        let viewController = SpeechDetailViewController(speech: speech, presenter: presenter)
        navigation.pushViewController(viewController, animated: true)
    }
    
    func setupApplicationWindow(_ window: UIWindow?) {
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
