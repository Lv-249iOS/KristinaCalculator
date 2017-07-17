//
//  SettingsController.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 7/8/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit
import AVFoundation

/// Class conrtols settings of sound, themes and animation 
class SettingsController: UIViewController {
    @IBOutlet weak var animationSwitcher: UISwitch!
    @IBOutlet weak var themeSwitcher: UISwitch!
    @IBOutlet weak var soundSwitcher: UISwitch!
    
    @IBOutlet var Labels: [UILabel]!
    var isSound = false
    
    /// On/Off animation
    @IBAction func changeStateOfAnimation(_ sender: Any) {
        UserDefaults.standard.setValue(animationSwitcher.isOn, forKey: "animationSwitcher")
        NotificationCenter.default.post(name: kChangeAnimationState, object: nil)
        buttonPressedSound()
    }

    /// switch between light and dark theme
    @IBAction func changeTheme(_ sender: UISwitch) {
        UserDefaults.standard.setValue(themeSwitcher.isOn, forKey: "themeSwitcher")
        NotificationCenter.default.post(name: kChangeStyleColor, object: nil)
        buttonPressedSound()
    }
    
    /// On/Off sound of click on buttons
    @IBAction func changeStateOfSound(_ sender: UISwitch) {
        UserDefaults.standard.setValue(soundSwitcher.isOn, forKey: "soundSwitcher")
        NotificationCenter.default.post(name: kChangeSoundState, object: nil)
        buttonPressedSound()
    }
    
    // If sound ON makes sound
    func buttonPressedSound() {
        if isSound {
            AudioServicesPlaySystemSound(1022)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setTheme), name: kChangeStyleColor, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setSoundOnOff), name: kChangeSoundState, object: nil)
        
        themeSwitcher.isOn = (UserDefaults.standard.value(forKey: "themeSwitcher") as? Bool)!
        soundSwitcher.isOn = (UserDefaults.standard.value(forKey: "soundSwitcher") as? Bool)!
        animationSwitcher.isOn = (UserDefaults.standard.value(forKey: "animationSwitcher") as? Bool)!
        
        setTheme()
        setSoundOnOff()
    }

    func setTheme() {
        view.backgroundColor = style.currentStyle["backgroundColor"]
        for label in Labels {
            label.textColor = style.currentStyle["textColor"]
        }
    }

    func setSoundOnOff() {
        isSound = UserDefaults.standard.value(forKey: "soundSwitcher") as! Bool
    }
}
