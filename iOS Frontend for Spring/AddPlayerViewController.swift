//
//  AddPlayerViewController.swift
//  iOS Frontend for Spring
//
//  Created by Xavi Moll Villalonga on 21/04/16.
//  Copyright © 2016 Xavi Moll. All rights reserved.
//

import UIKit
import Alamofire

protocol DelegateForDismissingTheDetailsOfThePlayer: class {
    func dismissDetailsPlayer()
}

class AddPlayerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var nombreJugadorTextField: UITextField!
    @IBOutlet weak var canastasJugadorTextField: UITextField!
    @IBOutlet weak var rebotesJugadorTextField: UITextField!
    @IBOutlet weak var asistenciasJugadorTextField: UITextField!
    @IBOutlet weak var posicionCampoPickerView: UIPickerView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var player: Player?
    var posicionesCampo = [String]()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    weak var delegateToDismissTheDetailsOfThePlayer: DelegateForDismissingTheDetailsOfThePlayer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        posicionesCampo = ["Alero", "Base", "Pivot"]
        doneButton.enabled = false
        nombreJugadorTextField.addTarget(self, action: #selector(AddPlayerViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        if let _ = player {
            titleLabel.text = "Actualizar el jugador"
            nombreJugadorTextField.text = player!.name!
            canastasJugadorTextField.text = String(player!.baskets!)
            rebotesJugadorTextField.text = String(player!.rebotes!)
            asistenciasJugadorTextField.text = String(player!.asistencias!)
            for (index, posicion) in posicionesCampo.enumerate() {
                if posicion == player!.posicionCampo! {
                    posicionCampoPickerView.selectRow(index, inComponent: 0, animated: true)
                    break
                }
            }
            doneButton.setTitle("Update", forState: .Normal)
            doneButton.enabled = true
        }
    }
    
    @IBAction func cancelAddPlayer(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addPlayer(sender: UIButton) {
        
        let jugadorName = nombreJugadorTextField.text!
        
        var canastasJugador = 0
        var rebotesJugador = 0
        var asistenciasJugador = 0
        
        if canastasJugadorTextField.text! != "" {
            canastasJugador = Int(canastasJugadorTextField.text!)!
        }
        
        if rebotesJugadorTextField.text! != "" {
            rebotesJugador = Int(rebotesJugadorTextField.text!)!
        }
        
        if asistenciasJugadorTextField.text! != "" {
            asistenciasJugador = Int(asistenciasJugadorTextField.text!)!
        }
        
        let indexSelected = posicionCampoPickerView.selectedRowInComponent(0)
        let posicionCampo = posicionesCampo[indexSelected]
        
        
        
        let headersRequest = ["Authorization" : "Bearer \((defaults.objectForKey("accessToken") as! String))",
                              "Content-Type"  : "application/json"]
        
        if sender.titleLabel!.text! == "Done" {
            let bodyHTTP = ["name"      : jugadorName,
                            "baskets"       : canastasJugador,
                            "rebotes"       : rebotesJugador,
                            "asistencias"   : asistenciasJugador,
                            "posicionCampo" : posicionCampo]
            
            Alamofire.request(.POST, "http://\(Helper().serverIP)/api/players", parameters: bodyHTTP as? [String: AnyObject], headers: headersRequest, encoding: .JSON).responseJSON{ response in
                switch response.result {
                case .Success:
                    self.dismissViewControllerAnimated(true, completion: nil)
                case .Failure (let error):
                    print("Request failed with error: \(error)")
                }
            }
        } else if sender.titleLabel!.text! == "Update" {
            //Update the player here
            let bodyHTTP = ["name"      : jugadorName,
                            "baskets"       : canastasJugador,
                            "rebotes"       : rebotesJugador,
                            "asistencias"   : asistenciasJugador,
                            "posicionCampo" : posicionCampo,
                            "id"            : player!.id!]
            
            Alamofire.request(.PUT, "http://\(Helper().serverIP)/api/players", parameters: bodyHTTP as? [String: AnyObject], headers: headersRequest, encoding: .JSON).responseJSON{ response in
                switch response.result {
                case .Success:
                    self.dismissViewControllerAnimated(true, completion: nil)
                    self.delegateToDismissTheDetailsOfThePlayer?.dismissDetailsPlayer()
                case .Failure (let error):
                    print("Request failed with error: \(error)")
                }
            }
        }
        
    }
    
    func textFieldDidChange(sender: UITextField) {
        if let nombre = sender.text {
            if nombre.characters.count > 0 {
                doneButton.enabled = true
            } else {
                doneButton.enabled = false
            }
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return posicionesCampo.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(posicionesCampo[row])"
    }

}
