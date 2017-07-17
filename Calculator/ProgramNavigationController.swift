//
//  ProgramNavigationController.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 7/11/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit
import AVFoundation

/// Main HOME screen controller that navigates between settings scene and calcutator scene
class ProgramNavigationController: UIViewController {
    @IBOutlet weak var imageBackground: UIImageView!
    var emitter: CAEmitterLayer!
    var isSound = false
    
    @IBAction func buttonsTap(_ sender: UIButton) {
        isSound ? AudioServicesPlaySystemSound(1104) : (/* keep silance */)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set settings in the first launch of program on the devices
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
    
    // if willTransition change size anf position of animation
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
    
    // set theme for home screen
    func setTheme() {
        view.backgroundColor = style.currentStyle["backgroundColor"]
        imageBackground.image = style.currentHomeImage
    }

    // Set sound state
    func setSoundOnOff() {
        isSound = UserDefaults.standard.value(forKey: "soundSwitcher") as! Bool
    }
    
    // Set emitter of imagee on the home screen
    func setImageEmitter() {
        if UserDefaults.standard.value(forKey: "animationSwitcher") as! Bool {
            setThemeImageEmitter()
            view.layer.addSublayer(emitter!)
        } else {
            emitter?.removeFromSuperlayer()
            emitter = nil
        }
    }
    
    // Set all the settings of emitter such as size, birthrate and so on
    func setThemeImageEmitter() {
        emitter?.removeFromSuperlayer()

        ImageEmitter.styleSettings = style.currentEmitter
        emitter = ImageEmitter.get(with: style.currentImageForEmitting)
        emitter.emitterPosition = CGPoint(x: view.frame.width / 2, y: 0)
        emitter.emitterSize = CGSize(width: view.frame.width, height: 2)
    }
}
