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
    
    @IBOutlet weak var fontPickerView: UIPickerView!
    @IBOutlet weak var animationSwitcher: UISwitch!
    @IBOutlet weak var themeSwitcher: UISwitch!
    @IBOutlet weak var soundSwitcher: UISwitch!

    @IBOutlet var Labels: [UILabel]!
    var isSound = false
    
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
        NotificationCenter.default.addObserver(fontPickerView, selector: #selector(fontPickerView.reloadAllComponents), name: kChangeStyleColor, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setSoundOnOff), name: kChangeSoundState, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setFont), name: kChangeFont, object: nil)
        
        themeSwitcher.isOn = setStateOfSwitcherFromUserDefaults(key: "themeSwitcher")
        soundSwitcher.isOn = setStateOfSwitcherFromUserDefaults(key: "soundSwitcher")
        animationSwitcher.isOn = setStateOfSwitcherFromUserDefaults(key: "animationSwitcher")
        fontPickerView.selectRow(getFontDefaultIndex(key: "appFont"), inComponent: 0, animated: false)
        
        setFont()
        setTheme()
        setSoundOnOff()
    }
    
    func setStateOfSwitcherFromUserDefaults(key: String) -> Bool {
        guard let state = UserDefaults.standard.value(forKey: key) as? Bool else { return true }
        return state
    }
    
    func getFontDefaultIndex(key: String) -> Int {
        if let fontName = UserDefaults.standard.value(forKey: key) as? String, let index = UIFont.familyNames.index(of: fontName) {
            return index
        } else {
            return 1
        }
    }
    
    func buttonPressedSound() {
        if isSound {
            AudioServicesPlaySystemSound(1022)
        }
    }
    
    func setFont() {
        for label in Labels {
            label.font = UIFont(name: style.currentFont, size: 20.0)
        }
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

extension SettingsController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    /// Return number of columns in PickerView (UIPickerViewDataSource protocol's method)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /// Return count of components in pickerView (UIPickerViewDataSource protocol's method)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return UIFont.familyNames.count
    }
    
    /// Return view of each row in PickerView (UIPickerViewDelegate protocol)
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: UIFont.familyNames[row], attributes: [NSForegroundColorAttributeName: style.currentStyle["textColor"]!])
    }
    
    /// Called when some row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.setValue(UIFont.familyNames[row], forKey: "appFont")
        NotificationCenter.default.post(name: kChangeFont, object: nil)
    }
}

