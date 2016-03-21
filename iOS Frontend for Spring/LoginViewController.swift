//
//  ViewController.swift
//  iOS Frontend for Spring
//
//  Created by Xavi Moll Villalonga on 17/03/16.
//  Copyright © 2016 Xavi Moll. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func login(sender: UIButton) {
        print(usernameText.text)
        print(passwordText.text)
        
        let bodyHTTP = ["user": "\(usernameText.text!)", "password": "\(usernameText.text!)"]
        let headersRequest = ["":""]
        
        Alamofire.request(.POST, "http://172.16.155.36:8080", parameters: bodyHTTP, headers: headersRequest).responseJSON{ response in
            switch response.result {
            case .Success (let JSON):
                if let _ = JSON["error"]! {
                    print(JSON["error"])
                } else {
                    if let _ = JSON as? [String:AnyObject] {
                        print("The notifications for this challenge are ON")
                    }
                }
            case .Failure (let error):
                print("Request failed with error: \(error)")
            }
        }
        
        
        
        
    }
}

