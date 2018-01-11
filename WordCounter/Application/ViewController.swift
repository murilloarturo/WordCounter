//
//  ViewController.swift
//  WordCounter
//
//  Created by Arturo on 1/10/18.
//  Copyright © 2018 Arturo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let filepath = Bundle.main.url(forResource: "speeches", withExtension: "json"), let data = try? Data(contentsOf: filepath) else {
            return
        }
        
//        do {
//            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
//
//        } catch let error as NSError {
//            print("Failed to load: \(error.localizedDescription)")
//        }
        do {
            let string: NSAttributedString = try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
            
            let attributedStringWithRtf: NSAttributedString = try NSAttributedString(url: filepath, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtf], documentAttributes: nil)
            
            print(attributedStringWithRtf)
            
            let plainString = attributedStringWithRtf.string
            let jsonData = plainString.data(using: String.Encoding.utf8)
            
            let json = try JSONSerialization.jsonObject(with: jsonData!, options: []) as? [String: Any]

            print("PRUBA IT WORKED")
            
            
            
        } catch let error {
            print("Got an error \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

