//
//  Speech.swift
//  WordCounter
//
//  Created by Arturo on 1/11/18.
//  Copyright © 2018 Arturo. All rights reserved.
//

import Foundation

class SpeechArray: Codable {
    let speeches: [Speech]
}

class Speech: Codable {
    let orator: String
    let date: Date
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case orator = "name"
        case date
        case text = "speech"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orator = try container.decode(String.self, forKey: .orator)
        text = try container.decode(String.self, forKey: .text)
        
        let dateString = try container.decode(String.self, forKey: .date)
        let dateFormatter = DateFormatter.speechDateFormatter()
        if let date = dateFormatter.date(from: dateString) {
            self.date = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: LanguageString.errorParsingSpeechData.localizedString())
        }
    }
}

extension DateFormatter {
    static func speechDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        return formatter
    }
}
