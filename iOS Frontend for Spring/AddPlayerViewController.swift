//
//  AddPlayerViewController.swift
//  iOS Frontend for Spring
//
//  Created by Xavi Moll Villalonga on 21/04/16.
//  Copyright © 2016 Xavi Moll. All rights reserved.
//

import UIKit
import Alamofire

class AddPlayerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var nombreJugadorTextField: UITextField!
    @IBOutlet weak var canastasJugadorTextField: UITextField!
    @IBOutlet weak var rebotesJugadorTextField: UITextField!
    @IBOutlet weak var asistenciasJugadorTextField: UITextField!
    @IBOutlet weak var posicionCampoPickerView: UIPickerView!
    @IBOutlet weak var doneButton: UIButton!
    
    var posicionesCampo = [String]()
    let defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        posicionesCampo = ["Alero", "Base", "Pivot"]
        doneButton.enabled = false
        nombreJugadorTextField.addTarget(self, action: #selector(AddPlayerViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
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
        
        let bodyHTTP = ["name"      : jugadorName,
                    "baskets"       : canastasJugador,
                    "rebotes"       : rebotesJugador,
                    "asistencias"   : asistenciasJugador,
                    "posicionCampo" : posicionCampo]
        
        let headersRequest = ["Authorization" : "Bearer \((defaults.objectForKey("accessToken") as! String))",
                              "Content-Type"  : "application/json"]
        
        Alamofire.request(.POST, "http://172.16.155.36:8080/api/players", parameters: bodyHTTP as? [String: AnyObject], headers: headersRequest, encoding: .JSON).responseJSON{ response in
            switch response.result {
            case .Success (let JSON):
                print(JSON)
                self.dismissViewControllerAnimated(true, completion: nil)
            case .Failure (let error):
                print("Request failed with error: \(error)")
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
