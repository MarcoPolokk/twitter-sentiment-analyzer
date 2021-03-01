//
//  ViewController.swift
//  twitter-sentiment-analyzer
//
//  Created by Paweł Kozioł on 25/02/2021.
//

import UIKit
import SwifteriOS

class ViewController: UIViewController {
    
    @IBOutlet weak var sentimentLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let swifter = Swifter(consumerKey: "ldYK2mF8vYt4tpTOHLhEBxMWe", consumerSecret: "1FORawqFRG3K6tqqFgcEaOQ6cfkR3ruF2oSfNxT9upxdkUaOir")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended) { (results, metadata) in
            print(results)
        } failure: { (error) in
            print("There was an error with Twitter API Request, \(error)")
        }

    }

    @IBAction func predictPressed(_ sender: UIButton) {
    }
    
}

