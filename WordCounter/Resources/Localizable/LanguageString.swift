//
//  LanguageString.swift
//  WordCounter
//
//  Created by Arturo on 1/11/18.
//  Copyright © 2018 Arturo. All rights reserved.
//

import Foundation

enum LanguageString: String {
    case errorParsingSpeechData
    case errorJSONFileNotFound
    case errorParsingJSONFile
    case errorFindingFrequentWord
    
    case speechTitle
    case speechFrequentWord
    case speechOratorName
    case speechDate
    
    func localizedString() -> String {
        return NSLocalizedString(rawValue, comment: "")
    }
    
    func localizedString(params: [String]) -> String {
        return String(format: localizedString(), arguments: params)
    }
}

