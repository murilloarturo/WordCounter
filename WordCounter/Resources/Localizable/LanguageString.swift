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
    case errorParsingSpeechData = "There was an error when trying to parse the data of the speech."
    case errorJSONFileNotFound = "The json file was not found."
    case errorParsingJSONFile = "There was an error when trying to load data from JSON file."
    
    func localizedString() -> String {
        return NSLocalizedString(rawValue, comment: "")
    }
}

