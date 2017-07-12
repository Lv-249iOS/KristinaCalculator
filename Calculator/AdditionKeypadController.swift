//
//  AdditionKeypadController.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 7/3/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class AdditionKeypadController: UIViewController {
    var onSymbolTap: ((_ button: UIButton)->())?
    var keypadPlus: KeypadPlusController!
    
    @IBAction func dismissPopup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func onUtilitySymbolTap(_ button: UIButton) {
        onSymbolTap?(button)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "KeypadPlusSegue", let controller = segue.destination as? KeypadPlusController {
            keypadPlus = controller
            
            keypadPlus.onButtonTap = { [weak self] button in
                self?.onUtilitySymbolTap(button)
            }
        }
    }
}
