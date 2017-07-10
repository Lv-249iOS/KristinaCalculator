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
    
    @IBOutlet var DigitButtons: [UIButton]!
    @IBOutlet var UtilityButtons: [UIButton]!
    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var keypadPlus: UIStackView!
    
    var popUpAdditionKeypad: AdditionKeypadController!
    var sideAdditionkeypad: KeypadPlusController!
    
    @IBAction func onNumericTap(button: UIButton) {
        onNumTap?(button.tag)
    }
    
    @IBAction func onUtilityTap(button: UIButton) {
        onUtilityTap?(button.tag)
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
        UIDevice.current.orientation.isLandscape ? isHiddenKeypadPlus(false) : isHiddenKeypadPlus(true)
    }
    
    private func isHiddenKeypadPlus(_ state: Bool) {
        keypadPlus?.isHidden = state
        arrowButton?.isEnabled = state
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.orientation.isLandscape ? isHiddenKeypadPlus(false) : isHiddenKeypadPlus(true)
        NotificationCenter.default.addObserver(self, selector: #selector(changeTheme), name: CHANGE_STYLE_COLOR, object: nil)
    }
    
    func changeTheme() {
        if UserDefaults.standard.value(forKey: "themeSwitcher") as! Bool {
            for but in DigitButtons {
                but.backgroundColor = StyleManager.shared.LightTheme["backgroundColor"]
                but.setTitleColor(StyleManager.shared.LightTheme["textColor"], for: .normal)
            }
            for but in UtilityButtons {
                but.backgroundColor = StyleManager.shared.LightTheme["backgroundColor"]
                but.setTitleColor(StyleManager.shared.LightTheme["textColor"], for: .normal)
            }
        } else {
            for but in DigitButtons {
                but.backgroundColor = StyleManager.shared.DarkTheme["backgroundColor"]
                but.setTitleColor(StyleManager.shared.DarkTheme["textColor"], for: .normal)
            }
            for but in UtilityButtons {
                but.backgroundColor = StyleManager.shared.DarkTheme["backgroundColor"]
                but.setTitleColor(StyleManager.shared.DarkTheme["textColor"], for: .normal)
            }
        }
    }
    
}
