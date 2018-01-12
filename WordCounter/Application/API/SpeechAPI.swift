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
    case unableToFindFrequentWord
    
    var localizedDescription: String {
        switch self {
        case .jsonFileNotFound:
            return LanguageString.errorJSONFileNotFound.localizedString()
        case .parsingJSONFile:
            return LanguageString.errorParsingJSONFile.localizedString()
        case .unableToFindFrequentWord:
            return LanguageString.errorFindingFrequentWord.localizedString()
        }
    }
}

class SpeechAPI {
    private let progress = Variable<Float>(0.0)
    
    func loadData() -> Observable<[Speech]> {
        return loadJSONFile().flatMap({ (jsonData) -> Observable<[Speech]> in
            guard let data = jsonData else {
                return Observable.error(APIError.parsingJSONFile)
            }
            return self.parseJSON(data)
        })
    }
    
    func findMostFrequentWord(from text: String) -> Single<String> {
        return Single.create(subscribe: { (single) -> Disposable in
            DispatchQueue.global(qos: .background).async {
                if let word = self.mostUsedWord(from: text) {
                    single(.success(word))
                } else {
                    single(.error(APIError.unableToFindFrequentWord))
                }
            }
            return Disposables.create()
        })
    }
    
    func getProgress() -> Observable<Float> {
        return progress.asObservable()
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
    
    func mostUsedWord(from text: String) -> String? {
        guard !text.isEmpty else {
            return nil
        }
        
        progress.value = 0.0
        let words = text.components(separatedBy: CharacterSet.alphanumerics.inverted)
        var values: [String: Int] = [:]
        words.forEach {
            guard !$0.isEmpty else {
                return
            }
            let string =  $0.lowercased()
            if let repeted = values[string] {
                values[string] = repeted + 1
            } else {
                values[string] = 1
            }
        }
        progress.value = 0.6
        
        var mostUsedString: (word: String, times: Int)?
        values.forEach {
            guard let word = mostUsedString else {
                mostUsedString = ($0.key, $0.value)
                return
            }
            if $0.value > word.times {
                mostUsedString = ($0.key, $0.value)
            }
        }
        
        progress.value = 1
        return mostUsedString?.word
    }
}
