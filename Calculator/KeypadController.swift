//
//  KeypadController.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 6/28/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit
import AVFoundation

class KeypadController: UIViewController {
    var onNumTap: ((_ num: Int)->())?
    var onUtilityTap: ((_ symbol: Int)->())?
    
    var popUpAdditionKeypad: AdditionKeypadController!
    var sideAdditionkeypad: KeypadPlusController!
    var sound = false
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    
    @IBAction func onNumericTap(button: UIButton) {
        onNumTap?(button.tag)
        buttonPressedSound()
    }
    
    @IBAction func onUtilityTap(button: UIButton) {
        onUtilityTap?(button.tag)
        buttonPressedSound()
    }
    
    @IBAction func buttonTap(_ sender: UIButton) {
        buttonPressedSound()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AdditionKeypadSegue", let controller = segue.destination as? AdditionKeypadController {
            popUpAdditionKeypad = controller
            
            popUpAdditionKeypad.onSymbolTap = { [weak self] button in
                self?.onUtilityTap(button: button)
            }
        } else if segue.identifier == "KeypadPlusForLandscapeSegue", let controller = segue.destination as? KeypadPlusController {
            sideAdditionkeypad = controller
            
            sideAdditionkeypad.onButtonTap = { [weak self] button in
                self?.onUtilityTap(button: button)
            }
        }
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        UIDevice.current.orientation.isLandscape ? (arrowButton.isEnabled = false) : (arrowButton.isEnabled = true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.orientation.isLandscape ? (arrowButton.isEnabled = false) : (arrowButton.isEnabled = true)
        sound = (UserDefaults.standard.value(forKey: "soundSwitcher") as? Bool)!
        setTheme()
    }
    
    func setTheme() {
        if UserDefaults.standard.value(forKey: "themeSwitcher") as! Bool {
            for but in buttons {
                if but.tag >= 0 && but.tag <= 10 || but.tag == 10015 { // but.tag 10 is arrow ; tag 10015 is dot
                    but.backgroundColor = StyleManager.shared.darkTheme["buttonColor"]
                } else {
                    (but.backgroundColor = StyleManager.shared.darkTheme["UtilitybuttonColor"])
                }
                
                but.setTitleColor(StyleManager.shared.darkTheme["textColor"], for: .normal)
            }
            equalButton.backgroundColor = StyleManager.shared.darkTheme["equal"]
        } else {
            for but in buttons {
                if but.tag >= 0 && but.tag <= 10 || but.tag == 10015 { // but.tag 10 is arrow ; tag 10015 is dot
                    but.backgroundColor = StyleManager.shared.lightTheme["buttonColor"]
                } else {
                    but.backgroundColor = StyleManager.shared.lightTheme["UtilitybuttonColor"]
                }
                
                but.setTitleColor(StyleManager.shared.lightTheme["textColor"], for: .normal)
            }
            equalButton.backgroundColor = StyleManager.shared.lightTheme["equal"]
        }
    }
    
    func buttonPressedSound() {
        if sound {
            AudioServicesPlaySystemSound(1104)
        }
    }
}
