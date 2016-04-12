//
//  PlayerDetailsViewController.swift
//  iOS Frontend for Spring
//
//  Created by Xavi Moll Villalonga on 17/03/16.
//  Copyright © 2016 Xavi Moll. All rights reserved.
//

import UIKit
import Alamofire

class PlayerDetailsViewController: UIViewController {
    
    @IBOutlet weak var numberOfBasketsLabel: UILabel!
    var player: Player?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = player {
            title = player!.name!
            numberOfBasketsLabel.text! = String(player!.baskets!)
        }
    }
}
