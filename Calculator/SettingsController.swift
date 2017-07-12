//
//  SettingsController.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 7/8/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsController: UIViewController {
    @IBOutlet weak var themeSwitcher: UISwitch!
    @IBOutlet weak var soundSwitcher: UISwitch!
    @IBOutlet var Labels: [UILabel]!
    
    var sound = false
    
    @IBAction func changeTheme(_ sender: UISwitch) {
        UserDefaults.standard.setValue(themeSwitcher.isOn, forKey: "themeSwitcher")
        NotificationCenter.default.post(name: kChangeStyleColor, object: nil)
        if sound {
            AudioServicesPlaySystemSound(1016)
        }
    }
    
    @IBAction func changeStateOfSound(_ sender: UISwitch) {
        UserDefaults.standard.setValue(soundSwitcher.isOn, forKey: "soundSwitcher")
        NotificationCenter.default.post(name: kChangeSoundState, object: nil)
        if sound {
            AudioServicesPlaySystemSound(1016)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setTheme), name: kChangeStyleColor, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SoundOnOff), name: kChangeSoundState, object: nil)
        
        if let state = UserDefaults.standard.value(forKey: "themeSwitcher") {
            themeSwitcher.isOn = (state as? Bool)!
        } else {
            UserDefaults.standard.setValue(true, forKey: "themeSwitcher")
            themeSwitcher.isOn = (UserDefaults.standard.value(forKey: "themeSwitcher") as? Bool)!
        }
        
        if let soundState = UserDefaults.standard.value(forKey: "soundSwitcher") {
            soundSwitcher.isOn = (soundState as? Bool)!
        } else {
            UserDefaults.standard.setValue(true, forKey: "soundSwitcher")
            soundSwitcher.isOn = (UserDefaults.standard.value(forKey: "soundSwitcher") as? Bool)!
        }
        
        setTheme()
        SoundOnOff()
    }
    
    func setTheme() {
        if UserDefaults.standard.value(forKey: "themeSwitcher") as! Bool {
            view.backgroundColor = StyleManager.shared.darkTheme["backgroundColor"]
            for label in Labels {
                label.textColor = StyleManager.shared.darkTheme["textColor"]
            }
        } else {
            view.backgroundColor = StyleManager.shared.lightTheme["backgroundColor"]
            for label in Labels {
                label.textColor = StyleManager.shared.lightTheme["textColor"]
            }
        }
    }
    
    func SoundOnOff() {
        sound = UserDefaults.standard.value(forKey: "soundSwitcher") as! Bool
    }
}
