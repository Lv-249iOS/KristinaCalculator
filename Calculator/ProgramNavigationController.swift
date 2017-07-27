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
    @IBOutlet var buttons: [RoundButton]!
    
    var emitter: CAEmitterLayer?
    var isSound = false
    
    @IBAction func buttonsTap(_ sender: UIButton) {
        isSound ? AudioServicesPlaySystemSound(1104) : (/* keep silence */)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTheme()
        setFont()
        setSoundOnOff()
        setImageEmitter()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setTheme), name: kChangeStyleColor, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setFont), name: kChangeFont, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setSoundOnOff), name: kChangeSoundState, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setImageEmitter), name: kChangeAnimationState, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setImageEmitter), name: kChangeStyleColor, object: nil)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if emitter != nil {
            if UIDevice.current.orientation.isLandscape {
                emitter?.emitterSize = CGSize(width: view.frame.height, height: 2)
                emitter?.emitterPosition = CGPoint(x: view.frame.height / 2, y: 0)
            } else {
                emitter?.emitterSize = CGSize(width: view.frame.width, height: 2)
                emitter?.emitterPosition = CGPoint(x: view.frame.width / 2, y: 0)
            }
        }
    }
    
    func setFont() {
        for but in buttons {
            but.titleLabel?.font = UIFont(name: style.currentFont, size: 20)
        }
    }
    
    func setTheme() {
        view.backgroundColor = style.currentStyle["backgroundColor"]
        imageBackground.image = style.currentHomeImage
    }

    func setSoundOnOff() {
        isSound = UserDefaults.standard.value(forKey: "soundSwitcher") as? Bool ?? true
    }
    
    func setImageEmitter() {
        if UserDefaults.standard.value(forKey: "animationSwitcher") as! Bool {
            setThemeImageEmitter()
            view.layer.addSublayer(emitter ?? CAEmitterLayer())
        } else {
            emitter?.removeFromSuperlayer()
            emitter = nil
        }
    }
    
    func setThemeImageEmitter() {
        emitter?.removeFromSuperlayer()

        emitter = ImageEmitter.get(with: style.currentImageForEmitting)
        emitter?.emitterPosition = CGPoint(x: view.frame.width / 2, y: 0)
        emitter?.emitterSize = CGSize(width: view.frame.width, height: 2)
    }
}
