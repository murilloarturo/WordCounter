//
//  LanguageString.swift
//  WordCounter
//
//  Created by Arturo on 1/11/18.
//  Copyright © 2018 Arturo. All rights reserved.
//

import Foundation

enum LanguageString: String {
    
    case speechTitle = "Speech List"
    
    func localizedString() -> String {
        return NSLocalizedString(rawValue, comment: "")
    }
}

