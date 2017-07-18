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
class SettingsController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var animationSwitcher: UISwitch!
    @IBOutlet weak var themeSwitcher: UISwitch!
    @IBOutlet weak var soundSwitcher: UISwitch!
    @IBOutlet weak var fontPickerView: UIPickerView!
    
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
        NotificationCenter.default.addObserver(fontPickerView, selector: #selector(fontPickerView.reloadAllComponents), name: kChangeStyleColor, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setSoundOnOff), name: kChangeSoundState, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setFont), name: kChangeFont, object: nil)
        
        themeSwitcher.isOn = (UserDefaults.standard.value(forKey: "themeSwitcher") as? Bool)!
        soundSwitcher.isOn = (UserDefaults.standard.value(forKey: "soundSwitcher") as? Bool)!
        animationSwitcher.isOn = (UserDefaults.standard.value(forKey: "animationSwitcher") as? Bool)!
        fontPickerView.selectRow(UIFont.familyNames.index(of: UserDefaults.standard.value(forKey: "appFont") as! String)!, inComponent: 0, animated: false)
        
        setFont()
        setTheme()
        setSoundOnOff()
    }
    
    /// from UIPickerViewDataSource protocol
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return UIFont.familyNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: UIFont.familyNames[row], attributes: [NSForegroundColorAttributeName: style.currentStyle["textColor"]!])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.setValue(UIFont.familyNames[row], forKey: "appFont")
        NotificationCenter.default.post(name: kChangeFont, object: nil)
    }
    
    func setFont() {
        for label in Labels {
            label.font = UIFont(name: style.currentFont, size: 20.0)
        }
    }

    func setTheme() {
        // set color for pickerView
        view.backgroundColor = style.currentStyle["backgroundColor"]
        for label in Labels {
            label.textColor = style.currentStyle["textColor"]
        }
    }

    func setSoundOnOff() {
        isSound = UserDefaults.standard.value(forKey: "soundSwitcher") as! Bool
    }
}
