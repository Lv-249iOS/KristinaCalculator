//
//  ProgramNavigationController.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 7/11/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit
import AVFoundation

class ProgramNavigationController: UIViewController {
    @IBOutlet weak var imageBackground: UIImageView!
    var sound = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "themeSwitcher") == nil {
            UserDefaults.standard.setValue(true, forKey: "themeSwitcher")
        }
        
        if UserDefaults.standard.value(forKey: "soundSwitcher") == nil {
            UserDefaults.standard.setValue(true, forKey: "soundSwitcher")
        }

        setTheme()
        SoundOnOff()
        NotificationCenter.default.addObserver(self, selector: #selector(setTheme), name: kChangeStyleColor, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SoundOnOff), name: kChangeSoundState, object: nil)
    }
    
    func setTheme() {
        if UserDefaults.standard.value(forKey: "themeSwitcher") as! Bool {
            self.view.backgroundColor = StyleManager.shared.darkTheme["backgroundColor"]
            imageBackground.image = #imageLiteral(resourceName: "winterNight")
            
        } else {
             self.view.backgroundColor = StyleManager.shared.lightTheme["backgroundColor"]
            imageBackground.image = #imageLiteral(resourceName: "summerDay")
        }
    }

    func SoundOnOff() {
        sound = UserDefaults.standard.value(forKey: "soundSwitcher") as! Bool
    }
}
