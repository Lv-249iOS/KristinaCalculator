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
    var isSound = false
    var emitter: CAEmitterLayer!
    
    @IBAction func buttonsTap(_ sender: UIButton) {
        isSound ? AudioServicesPlaySystemSound(1104) : (/* keep silance */)
    }
    
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
        setSoundOnOff()
        setImageEmitter()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setTheme), name: kChangeStyleColor, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setSoundOnOff), name: kChangeSoundState, object: nil)
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
        view.backgroundColor = style.currentStyle["backgroundColor"]
        imageBackground.image = style.currentHomeImage
    }

    func setSoundOnOff() {
        isSound = UserDefaults.standard.value(forKey: "soundSwitcher") as! Bool
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
        
        ImageEmitter.styleSettings = style.currentEmitter
        emitter = ImageEmitter.get(with: style.currentImageForEmitting)
        emitter.emitterPosition = CGPoint(x: view.frame.width / 2, y: 0)
        emitter.emitterSize = CGSize(width: view.frame.width, height: 2)
    }
}
