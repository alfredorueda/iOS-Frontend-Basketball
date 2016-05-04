//
//  PlayerDetailsViewController.swift
//  iOS Frontend for Spring
//
//  Created by Xavi Moll Villalonga on 17/03/16.
//  Copyright © 2016 Xavi Moll. All rights reserved.
//

import UIKit
import Alamofire

class PlayerDetailsViewController: UIViewController, DelegateForDismissingTheDetailsOfThePlayer {
    
    @IBOutlet weak var numberOfBasketsLabel: UILabel!
    @IBOutlet weak var numberOfRebotesLabel: UILabel!
    @IBOutlet weak var numberOfAsistenciasLabel: UILabel!
    @IBOutlet weak var posicionCampoLabel: UILabel!
    @IBOutlet weak var fechaNacimientoLabel: UILabel!
    
    var player: Player?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = player {
            
            title = player!.name!
            
            if let baskets = player!.baskets {
                numberOfBasketsLabel.text = String(baskets)
            }
            
            if let rebotes = player!.rebotes {
                numberOfRebotesLabel.text = String(rebotes)
            }
            
            if let asistencias = player!.asistencias {
                numberOfAsistenciasLabel.text = String(asistencias)
            }
            
            if let fechaNacimiento = player!.fechaNacimiento {
                fechaNacimientoLabel.text = fechaNacimiento
            }
            
            posicionCampoLabel.text = player!.posicionCampo!
        }
    }
    
    func dismissDetailsPlayer() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UpdatePlayer" {
            let vc = segue.destinationViewController as! AddEditPlayerViewController
            vc.player = player
            vc.delegateToDismissTheDetailsOfThePlayer = self
        }
    }
}
