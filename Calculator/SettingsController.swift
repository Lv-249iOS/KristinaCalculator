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
    
    @IBAction func changeTheme(_ sender: UISwitch) {
        UserDefaults.standard.setValue(themeSwitcher.isOn, forKey: "themeSwitcher")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let state = UserDefaults.standard.value(forKey: "themeSwitcher") {
            themeSwitcher.isOn = (state as? Bool)!
        } else {
            UserDefaults.standard.setValue(true, forKey: "themeSwitcher")
            themeSwitcher.isOn = (UserDefaults.standard.value(forKey: "themeSwitcher") as? Bool)!
        }
    }
}
