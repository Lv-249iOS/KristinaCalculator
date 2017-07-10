//
//  MainLayoutController.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 6/28/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class MainLayoutController: UIViewController, UIPopoverPresentationControllerDelegate {
    var display: InfoPresentedController!
    var keypad: KeypadController!
    var designSettings: SettingsController!
    
    let inputAdapter = IntputAdapter.shared
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InfoPresentedControllerSegue", let controller = segue.destination as? InfoPresentedController {
            display = controller
            
        } else if segue.identifier == "KeypadControllerSegue", let controller = segue.destination as? KeypadController {
            keypad = controller
            
            keypad.onNumTap = { [weak self] num in
                self?.onNumericTap(num: num)
            }
            
            keypad.onUtilityTap = { [weak self] symbol in
                self?.onUtilityTap(symbol: symbol)
            }
            
        } else if segue.identifier == "SettingsPopOverSegue", let controller = segue.destination as? SettingsController {
            designSettings = controller
            
            designSettings.popoverPresentationController?.delegate = self
            designSettings.popoverPresentationController?.sourceRect = CGRect(x: ((sender as? UIButton)?.bounds.midX)!, y: ((sender as? UIButton)?.bounds.midY)!, width: 0, height: 0)
            designSettings.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue(true, forKey: "themeSwitcher")
    }
    
    func onNumericTap(num: Int) {
        inputAdapter.enterNum(num)
    }
    
    func onUtilityTap(symbol: Int) {
        let op = Operation(rawValue: symbol)
        inputAdapter.enterUtility(op!)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
