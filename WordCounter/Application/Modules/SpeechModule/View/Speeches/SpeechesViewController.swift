//
//  SpeechesViewController.swift
//  WordCounter
//
//  Created by Arturo on 1/11/18.
//  Copyright © 2018 Arturo. All rights reserved.
//

import UIKit
import RxSwift

protocol SpeechesViewControllerPresenter: class {
    func loadSpeeches() -> Observable<[Speech]>
}

class SpeechesViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private let presenter: SpeechesViewControllerPresenter
    private let dataSource: SpeechesDataSource
    private let disposeBag = DisposeBag()
    
    init(presenter: SpeechesViewControllerPresenter, dataSource: SpeechesDataSource) {
        self.presenter = presenter
        self.dataSource = dataSource
        
        super.init(nibName: String(describing: SpeechesViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        //TODO: Logger
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bind()
    }
}

private extension SpeechesViewController {
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = false
        title = LanguageString.speechTitle.localizedString()
        
        tableView.registerNibForCell(with: SpeechTableViewCell.self)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
    }
    
    func bind() {
        presenter.loadSpeeches()
            .subscribe(onNext: { [weak self] (data) in
                self?.dataSource.data = data
                self?.tableView.reloadData()
            }, onError: { [weak self] (error) in
                //TODO: show error
            })
            .disposed(by: disposeBag)
    }
}
