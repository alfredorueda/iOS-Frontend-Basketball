//
//  PlayersCell.swift
//  iOS Frontend for Spring
//
//  Created by Xavi Moll Villalonga on 17/03/16.
//  Copyright © 2016 Xavi Moll. All rights reserved.
//

import UIKit

class PlayersCell: UITableViewCell {
    
    @IBOutlet weak var playerId: UILabel!
    @IBOutlet weak var playerName: UILabel!
    
    override func prepareForReuse() {
        playerId.text = ""
        playerName.text = ""
    }
    
}
