//
//  StyleManager.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 7/10/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

/// Contain dictionaries with settings for different styles of application UI
struct StyleManager {
    
    /// Singleton object of StyleManager for application
    static var shared = StyleManager()
    
    /// Light color set for app
    let lightTheme = [
        ElementsOfTheme.backgroundColor: UIColor(colorLiteralRed: 0.952, green: 0.946, blue: 0.934, alpha: 1),
        ElementsOfTheme.textColor: UIColor(colorLiteralRed: 0.273, green: 0.135, blue: 0.092, alpha: 1),
        ElementsOfTheme.buttonColor: UIColor(colorLiteralRed: 0.974, green: 0.969, blue: 0.957, alpha: 1),
        ElementsOfTheme.utilitybuttonColor: UIColor(colorLiteralRed: 0.867, green: 0.864, blue: 0.855, alpha: 1),
        ElementsOfTheme.equal: UIColor(colorLiteralRed: 0.964, green: 0.652, blue: 0.350, alpha: 1),
    ]
    
    /// Dark color set for app
    let darkTheme = [
        ElementsOfTheme.backgroundColor: UIColor(colorLiteralRed: 0.000, green: 0.047, blue: 0.073, alpha: 1),
        ElementsOfTheme.buttonColor: UIColor(colorLiteralRed: 0.000, green: 0.083, blue: 0.128, alpha: 1),
        ElementsOfTheme.utilitybuttonColor: UIColor(colorLiteralRed: 0.000, green: 0.215, blue: 0.331, alpha: 1),
        ElementsOfTheme.textColor: UIColor.white,
        ElementsOfTheme.equal: UIColor(colorLiteralRed: 0.623, green: 0.802, blue: 0.917, alpha: 1)
    ]
    
    /// Set of settings for emitter in DarkTheme
    let snowEmitter: [ElementForEmitter: Any] = [
        ElementForEmitter.emitterImage: #imageLiteral(resourceName: "snow"),
        ElementForEmitter.birthRate: Float(4),
        ElementForEmitter.lifetime: Float(17),
        ElementForEmitter.velocity: CGFloat(30),
        ElementForEmitter.scale: CGFloat(0.2),
        ElementForEmitter.scaleRange: CGFloat(0.06),
    ]
    
    /// Set of settings for emitter in LightTheme
    let bubblesEmitter: [ElementForEmitter: Any] = [
        ElementForEmitter.emitterImage: #imageLiteral(resourceName: "Bubbles"),
        ElementForEmitter.birthRate: Float(1.33),
        ElementForEmitter.lifetime: Float(15),
        ElementForEmitter.velocity: CGFloat(40),
        ElementForEmitter.scale: CGFloat(0.1),
        ElementForEmitter.scaleRange: CGFloat(0.09),
    ]

    /// Return current color style
    var currentStyle: [ElementsOfTheme: UIColor] {
        if let val = UserDefaults.standard.value(forKey: KeyForUserDefaults.themeSwitcher.rawValue) as? Bool {
            return val ? darkTheme : lightTheme
        }
        return darkTheme
    }
    
    /// Return current image for home screen
    var currentHomeImage: UIImage {
        if let val = UserDefaults.standard.value(forKey: KeyForUserDefaults.themeSwitcher.rawValue) as? Bool {
            return val ? #imageLiteral(resourceName: "winterNight") : #imageLiteral(resourceName: "summerDay")
        }
        return #imageLiteral(resourceName: "winterNight")
    }
    
    /// Return current image for emitting
    var currentImageForEmitting: UIImage {
        if let val = UserDefaults.standard.value(forKey: KeyForUserDefaults.themeSwitcher.rawValue) as? Bool {
            return val ? (snowEmitter[ElementForEmitter.emitterImage] as? UIImage ?? UIImage()) : (bubblesEmitter[ElementForEmitter.emitterImage] as? UIImage ?? UIImage())
        }
        return snowEmitter[ElementForEmitter.emitterImage] as? UIImage ?? UIImage()
    }
    
    /// Return current settings for emitter
    var currentEmitter: [ElementForEmitter: Any] {
        if let val = UserDefaults.standard.value(forKey: KeyForUserDefaults.themeSwitcher.rawValue) as? Bool {
            return val ? snowEmitter : bubblesEmitter
        }
        return snowEmitter
    }
    
    /// Return current font in app
    var currentFont: String {
        if let val = UserDefaults.standard.value(forKey: KeyForUserDefaults.appFont.rawValue) as? String {
            return val
        }
        return "PingFang HK"
    }
}
