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
    @IBOutlet weak var predictButton: UIButton!
    
    let sentimentClassifier = TweetSentimentClassifier()
    
    let swifter = Swifter(consumerKey: "ldYK2mF8vYt4tpTOHLhEBxMWe", consumerSecret: "1FORawqFRG3K6tqqFgcEaOQ6cfkR3ruF2oSfNxT9upxdkUaOir")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.backgroundColor = .white
        textField.attributedPlaceholder = NSAttributedString(string:"How do people feel about...", attributes:[NSAttributedString.Key.foregroundColor: UIColor.gray])

        predictButton.layer.cornerRadius = predictButton.bounds.width / 4
    }
    
    @IBAction func predictPressed(_ sender: UIButton) {
        
        if let searchText = textField.text {
            
            swifter.searchTweet(using: searchText, lang: "en", count: 100, tweetMode: .extended) { [self] (results, metadata) in
                
                var tweets = [TweetSentimentClassifierInput]()
                
                for i in 0..<100 {
                    if let tweet = results[i]["full_text"].string {
                        let tweetForClassification = TweetSentimentClassifierInput(text: tweet)
                        tweets.append(tweetForClassification)
                    }
                }
                
                do {
                    let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
                    
                    var sentimentScore = 0
                    
                    for pred in predictions {
                        let sentiment = pred.label
                        
                        if sentiment == "Pos" {
                            sentimentScore += 1
                        } else if sentiment == "Neg" {
                            sentimentScore -= 1
                        }
                    }
                    
                    if sentimentScore > 16 {
                        sentimentLabel.text = "😍"
                        
                    } else if sentimentScore > 8 {
                        sentimentLabel.text = "🙂"
                        
                    } else if sentimentScore < -8 {
                        sentimentLabel.text = "🙁"
                        
                    } else if sentimentScore < -16 {
                        sentimentLabel.text = "😤"
                        
                    } else {
                        sentimentLabel.text = "😐"
                    }
                    
                } catch {
                    print(error)
                }
                
            } failure: { (error) in
                print("There was an error with Twitter API Request, \(error)")
            }
        }
    }
    
}

