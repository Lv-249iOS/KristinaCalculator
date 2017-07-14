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
    @IBOutlet weak var animationSwitcher: UISwitch!
    @IBOutlet weak var themeSwitcher: UISwitch!
    @IBOutlet weak var soundSwitcher: UISwitch!
    
    @IBOutlet var Labels: [UILabel]!
    var sound = false
    
    @IBAction func changeStateOfAnimation(_ sender: Any) {
        UserDefaults.standard.setValue(animationSwitcher.isOn, forKey: "animationSwitcher")
        NotificationCenter.default.post(name: kChangeAnimationState, object: nil)
        buttonPressedSound()
    }

    @IBAction func changeTheme(_ sender: UISwitch) {
        UserDefaults.standard.setValue(themeSwitcher.isOn, forKey: "themeSwitcher")
        NotificationCenter.default.post(name: kChangeStyleColor, object: nil)
        buttonPressedSound()
    }
    
    @IBAction func changeStateOfSound(_ sender: UISwitch) {
        UserDefaults.standard.setValue(soundSwitcher.isOn, forKey: "soundSwitcher")
        NotificationCenter.default.post(name: kChangeSoundState, object: nil)
        buttonPressedSound()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setTheme), name: kChangeStyleColor, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(soundOnOff), name: kChangeSoundState, object: nil)
        
        themeSwitcher.isOn = (UserDefaults.standard.value(forKey: "themeSwitcher") as? Bool)!
        soundSwitcher.isOn = (UserDefaults.standard.value(forKey: "soundSwitcher") as? Bool)!
        animationSwitcher.isOn = (UserDefaults.standard.value(forKey: "animationSwitcher") as? Bool)!
        
        setTheme()
        soundOnOff()
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
    
    func buttonPressedSound() {
        if sound {
            AudioServicesPlaySystemSound(1022)
        }
    }
    
    func soundOnOff() {
        sound = UserDefaults.standard.value(forKey: "soundSwitcher") as! Bool
    }
}
