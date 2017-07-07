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
    
    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var keypadPlus: UIStackView!
    
    var additionKeypad: AdditionKeypadController!
    var keypad: KeypadPlusController!
    
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
        } else if segue.identifier == "KeypadPlusForLandscapeSegue", let controller = segue.destination as? KeypadPlusController {
            keypad = controller
            
            keypad.onButtonTap = { [weak self] button in
                self?.onUtilityTap(button: button)
            }
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            isVisibleKeypadPlus(true)
        } else {
            isVisibleKeypadPlus(false)
        }
    }
    
    private func isVisibleKeypadPlus(_ state: Bool) {
        keypadPlus?.isHidden = !state
        arrowButton?.isEnabled = !state
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice.current.orientation.isLandscape {
            isVisibleKeypadPlus(true)
        } else {
            isVisibleKeypadPlus(false)
        }
    }
    
}
