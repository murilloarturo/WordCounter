//
//  SpeechDetailViewController.swift
//  WordCounter
//
//  Created by Arturo on 1/11/18.
//  Copyright © 2018 Arturo. All rights reserved.
//

import UIKit
import RxSwift

protocol SpeechDetailViewControllerPresenter: class {
    func progress() -> Observable<Float>
    func mostUsedWord(from speech: String) -> Observable<String>
}

class SpeechDetailViewController: UIViewController {

    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var finalWordLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    private let presenter: SpeechDetailViewControllerPresenter
    private let speech: String
    private let orator: String
    private let disposeBag = DisposeBag()
    
    init(speech: String, orator: String, presenter: SpeechDetailViewControllerPresenter) {
        self.presenter = presenter
        self.speech = speech
        self.orator = orator
        
        super.init(nibName: String(describing: SpeechDetailViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.contentOffset = .zero
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        bind()
    }
}

private extension SpeechDetailViewController {
    func setupUI() {
        textView.text = speech
        titleLabel.text = LanguageString.speechFrequentWord.localizedString()
        title = orator
    }
    
    func bind() {
        presenter.mostUsedWord(from: speech)
            .subscribe(onNext: { [weak self] (word) in
                self?.finalWordLabel.text = word
                }, onError: { (erro) in
                    
            })
            .disposed(by: disposeBag)
        
        presenter.progress()
            .subscribe(onNext: { [weak self] (progress) in
                self?.progressView.setProgress(progress, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
