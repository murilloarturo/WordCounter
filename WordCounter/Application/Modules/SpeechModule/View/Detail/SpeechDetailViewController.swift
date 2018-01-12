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
    @IBOutlet private weak var loaderLabel: UILabel!
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var finalWordLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    private let presenter: SpeechDetailViewControllerPresenter
    private let speech: String
    
    init(speech: String, presenter: SpeechDetailViewControllerPresenter) {
        self.presenter = presenter
        self.speech = speech
        
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
}

private extension SpeechDetailViewController {
    func setupUI() {
        textView.text = speech
    }
}
