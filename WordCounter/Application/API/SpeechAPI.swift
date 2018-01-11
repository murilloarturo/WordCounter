//
//  SpeechAPI.swift
//  WordCounter
//
//  Created by Arturo on 1/11/18.
//  Copyright © 2018 Arturo. All rights reserved.
//

import Foundation
import RxSwift

enum APIError: Error {
    case jsonFileNotFound
    case parsingJSONFile
    
    var localizedDescription: String {
        switch self {
        case .jsonFileNotFound:
            return LanguageString.errorJSONFileNotFound.localizedString()
        case .parsingJSONFile:
            return LanguageString.errorParsingJSONFile.localizedString()
        }
    }
}

class SpeechAPI {
    func loadData() -> Observable<[Speech]> {
        return loadJSONFile().flatMap({ (jsonData) -> Observable<[Speech]> in
            guard let data = jsonData else {
                return Observable.error(APIError.parsingJSONFile)
            }
            return self.parseJSON(data)
        })
    }
}

private extension SpeechAPI {
    //You may wonder why I did this way
    //The file provided was rtf file instead of valid json
    func loadJSONFile() -> Observable<Data?> {
        return Observable.create({ (observable) -> Disposable in
            DispatchQueue.global(qos: .background).async {
                do {
                    guard let filepath = Bundle.main.url(forResource: "speeches", withExtension: "json") else {
                        observable.onError(APIError.jsonFileNotFound)
                        return
                    }
//                    let string = try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
                    let attributedStringWithRtf: NSAttributedString = try NSAttributedString(url: filepath, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
                    let plainString = attributedStringWithRtf.string
                    observable.onNext(plainString.data(using: String.Encoding.utf8))
                } catch let error {
                    observable.onError(error)
                }
            }
            return Disposables.create()
        })
    }
    
    func parseJSON(_ jsonData: Data) -> Observable<[Speech]> {
        do {
            let speechArray = try JSONDecoder().decode(SpeechArray.self, from: jsonData)
            return Observable.just(speechArray.speeches)
        } catch let error {
            return Observable.error(error)
        }
    }
}
