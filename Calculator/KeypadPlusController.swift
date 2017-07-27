//
//  KeypadPlusController.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 7/7/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

/// Class controles addition keypad and binds functionality via closure
class KeypadPlusController: UIViewController {
    
    var onButtonTap: ((_ sender: UIButton)->())?
    
    @IBOutlet var keypadPlus: [UIButton]!
    
    @IBAction func buttonTap(_ sender: UIButton) {
        onButtonTap?(sender)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        setFont()
    }
    
    func setTheme() {
        for but in keypadPlus {
            but.backgroundColor = style.currentStyle[ElementsOfTheme.utilitybuttonColor]
            but.setTitleColor(style.currentStyle[ElementsOfTheme.textColor], for: .normal)
        }
    }
    
    func setFont() {
        for but in keypadPlus {
            but.titleLabel?.font = UIFont(name: style.currentFont, size: 30.0)
        }
    }
}
