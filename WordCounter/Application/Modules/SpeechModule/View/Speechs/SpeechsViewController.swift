//
//  SpeechsViewController.swift
//  WordCounter
//
//  Created by Arturo on 1/11/18.
//  Copyright © 2018 Arturo. All rights reserved.
//

import UIKit

protocol SpeechsViewControllerPresenter: class {
    
}

class SpeechsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private let presenter: SpeechsViewControllerPresenter
    
    init(presenter: SpeechsViewControllerPresenter) {
        self.presenter = presenter
        
        super.init(nibName: String(describing: SpeechsViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        //TODO: Logger
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

private extension SpeechsViewController {
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = LanguageString.speechTitle.localizedString()
        
        
    }
}
