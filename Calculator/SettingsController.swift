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
        NotificationCenter.default.post(name: kChangeStyleColor, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setTheme), name: kChangeStyleColor, object: nil)
        
        if let state = UserDefaults.standard.value(forKey: "themeSwitcher") {
            themeSwitcher.isOn = (state as? Bool)!
        } else {
            UserDefaults.standard.setValue(true, forKey: "themeSwitcher")
            themeSwitcher.isOn = (UserDefaults.standard.value(forKey: "themeSwitcher") as? Bool)!
        }
        setTheme()
    }
    
    func setTheme() {
        if UserDefaults.standard.value(forKey: "themeSwitcher") as! Bool {
            view.backgroundColor = StyleManager.shared.darkTheme["backgroundColor"]
            // change label color
        } else {
            view.backgroundColor = StyleManager.shared.lightTheme["backgroundColor"]
        }
    }
}
