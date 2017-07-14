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
    var emitter: CAEmitterLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "themeSwitcher") == nil {
            UserDefaults.standard.setValue(true, forKey: "themeSwitcher")
        }
        
        if UserDefaults.standard.value(forKey: "soundSwitcher") == nil {
            UserDefaults.standard.setValue(true, forKey: "soundSwitcher")
        }
        
        if UserDefaults.standard.value(forKey: "animationSwitcher") == nil {
            UserDefaults.standard.setValue(true, forKey: "animationSwitcher")
        }

        setTheme()
        soundOnOff()
        setImageEmitter()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setTheme), name: kChangeStyleColor, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(soundOnOff), name: kChangeSoundState, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setImageEmitter), name: kChangeAnimationState, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setImageEmitter), name: kChangeStyleColor, object: nil)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if emitter != nil {
            if UIDevice.current.orientation.isLandscape {
                emitter.emitterSize = CGSize(width: view.frame.height, height: 2)
                emitter.emitterPosition = CGPoint(x: view.frame.height / 2, y: 0)
            } else {
                emitter.emitterSize = CGSize(width: view.frame.width, height: 2)
                emitter.emitterPosition = CGPoint(x: view.frame.width / 2, y: 0)
            }
        }
    }
    
    func setTheme() {
        if UserDefaults.standard.value(forKey: "themeSwitcher") as! Bool {
            view.backgroundColor = StyleManager.shared.darkTheme["backgroundColor"]
            imageBackground.image = #imageLiteral(resourceName: "winterNight")
            
        } else {
            view.backgroundColor = StyleManager.shared.lightTheme["backgroundColor"]
            imageBackground.image = #imageLiteral(resourceName: "summerDay")
        }
    }

    func soundOnOff() {
        sound = UserDefaults.standard.value(forKey: "soundSwitcher") as! Bool
    }
    
    
    func setImageEmitter() {
        if UserDefaults.standard.value(forKey: "animationSwitcher") as! Bool {
            setThemeImageEmitter()
            view.layer.addSublayer(emitter!)
        } else {
            emitter?.removeFromSuperlayer()
            emitter = nil
        }
    }
    
    func setThemeImageEmitter() {
        emitter?.removeFromSuperlayer()
        
        if UserDefaults.standard.value(forKey: "themeSwitcher") as! Bool {
            ImageEmitter.styleSettings = StyleManager.shared.snowEmitter
            emitter = ImageEmitter.get(with: StyleManager.shared.snowEmitter["emitterImage"] as! UIImage)
        } else {
            ImageEmitter.styleSettings = StyleManager.shared.bubblesEmitter
            emitter = ImageEmitter.get(with: StyleManager.shared.bubblesEmitter["emitterImage"] as! UIImage)
        }
        
        emitter.emitterPosition = CGPoint(x: view.frame.width / 2, y: 0)
        emitter.emitterSize = CGSize(width: view.frame.width, height: 2)
    }
}
