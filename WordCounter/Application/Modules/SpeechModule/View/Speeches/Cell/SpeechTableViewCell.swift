//
//  SpeechTableViewCell.swift
//  WordCounter
//
//  Created by Arturo on 1/11/18.
//  Copyright © 2018 Arturo. All rights reserved.
//

import UIKit

class SpeechTableViewCell: UITableViewCell {
    @IBOutlet private weak var oratorNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(with speech: Speech) {
        oratorNameLabel.text = speech.orator
    }
}
