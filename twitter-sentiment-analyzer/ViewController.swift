//
//  ViewController.swift
//  twitter-sentiment-analyzer
//
//  Created by Paweł Kozioł on 25/02/2021.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var sentimentLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let sentimentClassifier = TweetSentimentClassifier()
    
    let swifter = Swifter(consumerKey: "ldYK2mF8vYt4tpTOHLhEBxMWe", consumerSecret: "1FORawqFRG3K6tqqFgcEaOQ6cfkR3ruF2oSfNxT9upxdkUaOir")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let prediction = try! sentimentClassifier.prediction(text: "")
        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended) { (results, metadata) in
            
            var tweets = [String]()
            
            for i in 0..<100 {
                if let tweet = results[i]["full_text"].string {
                    tweets.append(tweet)
                }
            }
            
            
            print(results)
        } failure: { (error) in
            print("There was an error with Twitter API Request, \(error)")
        }
        
    }
    
    @IBAction func predictPressed(_ sender: UIButton) {
    }
    
}

