//
//  KeypadController.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 6/28/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class KeypadController: UIViewController {
    var onNumTap: ((_ num: Int)->())?
    var onUtilityTap: ((_ symbol: Int)->())?
    var onServiceTap: ((_ keyNum: Int)->())?
    
    var additionKeypad: AdditionKeypadController!
    
    @IBAction func onNumericTap(button: UIButton) {
        onNumTap?(button.tag)
    }
    
    @IBAction func onUtilityTap(button: UIButton) {
        onUtilityTap?(button.tag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AdditionKeypadSegue", let controller = segue.destination as? AdditionKeypadController {
            additionKeypad = controller
            
            additionKeypad.onSymbolTap = { [weak self] button in
                self?.onUtilityTap(button: button)
            }
        }
    }    
}
