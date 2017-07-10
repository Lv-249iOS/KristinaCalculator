//
//  SettingsController.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 7/8/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//



import UIKit

class SettingsController: UIViewController {
    
    @IBOutlet weak var themeSwitcher: UISwitch!
    @IBOutlet weak var fontSizeSteper: UIStepper!
    
    var isChangeToLight: ((_ color: UIColor)->())?
    
    @IBAction func changeTheme(_ sender: UISwitch) {
        themeSwitcher.isOn ? NotificationCenter.default.post(name: CHANGE_STYLE_COLOR, object: nil) :
            NotificationCenter.default.post(name: CHANGE_STYLE_COLOR, object: nil)
        
        UserDefaults.standard.setValue(themeSwitcher.isOn, forKey: "themeSwitcher")
    }

    @IBAction func changeFontSize(_ sender: UIStepper) {
    }

    override func viewWillAppear(_ animated: Bool) {
       if UserDefaults.standard.value(forKey: "themeSwitcher") != nil {
            themeSwitcher.setOn((UserDefaults.standard.value(forKey: "themeSwitcher") as? Bool)!, animated: false)
        }
    }
    
}
