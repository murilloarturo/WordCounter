//
//  SpeechAPITests.swift
//  WordCounterTests
//
//  Created by Arturo on 1/11/18.
//  Copyright © 2018 Arturo. All rights reserved.
//

@testable import WordCounter
import XCTest
import RxTest
import RxBlocking

class SpeechAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFindMostFrequentWord() {
        let speechAPI = SpeechAPI()
        let firstSpeech = "Este es un texto corto. Por mas que sea corto\ndebe devolver que la palabra mas usada es corto. Sin tener en cuenta los caracteres especiales que esten con la palabra corto"
        let frequentWord = "corto"
        
        let response = speechAPI.findMostFrequentWord(from: firstSpeech)
            .toBlocking()
            .materialize()
        
        switch response {
        case .completed(elements: let elements):
            XCTAssertFalse(elements.isEmpty)
            XCTAssertEqual(elements.first, frequentWord)
        case .failed(elements: _, error: let error):
            XCTFail("Expected result without error, but some error returned \(error.localizedDescription)")
        }
    }
    
}
