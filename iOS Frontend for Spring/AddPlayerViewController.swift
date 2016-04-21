//
//  AddPlayerViewController.swift
//  iOS Frontend for Spring
//
//  Created by Xavi Moll Villalonga on 21/04/16.
//  Copyright © 2016 Xavi Moll. All rights reserved.
//

import UIKit

enum PosicionesCampo {
    case Alero
    case Base
    case Pivot
}

class AddPlayerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var nombreJugadorTextField: UITextField!
    @IBOutlet weak var canastasJugadorTextField: UITextField!
    @IBOutlet weak var rebotesJugadorTextField: UITextField!
    @IBOutlet weak var asistenciasJugadorTextField: UITextField!
    @IBOutlet weak var posicionCampoPickerView: UIPickerView!
    @IBOutlet weak var doneButton: UIButton!
    
    var posicionesCampo = [PosicionesCampo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        posicionesCampo = [.Alero, .Base, .Pivot]
        doneButton.enabled = false
        nombreJugadorTextField.addTarget(self, action: #selector(AddPlayerViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
    }
    
    @IBAction func cancelAddPlayer(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addPlayer(sender: UIButton) {
        
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
