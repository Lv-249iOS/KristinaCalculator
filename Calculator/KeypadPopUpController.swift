//
//  KeypadPopUpController.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 7/6/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class KeypadPopUpController: UIViewController {
    var additionKeypad: AdditionKeypadController!
    var symbOn: ((_ button: UIButton)->())?
    
    @IBAction func dismissPopup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func onUtilitySymbolTap(_ button: UIButton) {
        symbOn?(button)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AdditionKeypadController", let controller = segue.destination as? AdditionKeypadController {
            
            additionKeypad = controller
            
            additionKeypad.onTap = { [weak self] button in
                self?.onUtilitySymbolTap(button)
            }

        }
    }
    
}
