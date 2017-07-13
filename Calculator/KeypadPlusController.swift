//
//  KeypadPlusController.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 7/7/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit


class KeypadPlusController: UIViewController {
    var onButtonTap: ((_ sender: UIButton)->())?
    
    @IBOutlet var keypadPlus: [UIButton]!
    
    @IBAction func buttonTap(_ sender: UIButton) {
        onButtonTap?(sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
    }
    
    func setTheme() {
        if UserDefaults.standard.value(forKey: "themeSwitcher") as! Bool {
            for but in keypadPlus {
                but.backgroundColor = StyleManager.shared.darkTheme["UtilitybuttonColor"]
                but.setTitleColor(StyleManager.shared.darkTheme["textColor"], for: .normal)
            }
        } else {
            for but in keypadPlus {
                but.backgroundColor = StyleManager.shared.lightTheme["UtilitybuttonColor"]
                but.setTitleColor(StyleManager.shared.lightTheme["textColor"], for: .normal)
            }
        }
    }
}
