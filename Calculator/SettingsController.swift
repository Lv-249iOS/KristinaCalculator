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
        NotificationCenter.default.post(name: CHANGE_STYLE_COLOR, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        themeSwitcher.setOn((UserDefaults.standard.value(forKey: "themeSwitcher") as? Bool)!, animated: false)
    }
}
