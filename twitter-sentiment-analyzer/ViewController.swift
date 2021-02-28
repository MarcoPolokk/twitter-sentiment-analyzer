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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func predictPressed(_ sender: UIButton) {
    }
    
}

