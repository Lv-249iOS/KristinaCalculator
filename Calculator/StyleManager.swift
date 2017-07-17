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
    static var shared = StyleManager()
    
    // Light color set for app
    let lightTheme = [
        "backgroundColor": UIColor(colorLiteralRed: 0.952, green: 0.946, blue: 0.934, alpha: 1),
        "textColor": UIColor(colorLiteralRed: 0.273, green: 0.135, blue: 0.092, alpha: 1),
        "buttonColor": UIColor(colorLiteralRed: 0.974, green: 0.969, blue: 0.957, alpha: 1),
        "UtilitybuttonColor": UIColor(colorLiteralRed: 0.867, green: 0.864, blue: 0.855, alpha: 1),
        "equal": UIColor(colorLiteralRed: 0.964, green: 0.652, blue: 0.350, alpha: 1),
    ]
    
    // Dark color set for app
    let darkTheme = [
        "backgroundColor": UIColor(colorLiteralRed: 0.000, green: 0.047, blue: 0.073, alpha: 1),
        "buttonColor": UIColor(colorLiteralRed: 0.000, green: 0.083, blue: 0.128, alpha: 1),
        "UtilitybuttonColor": UIColor(colorLiteralRed: 0.000, green: 0.215, blue: 0.331, alpha: 1),
        "textColor": UIColor.white,
        "equal": UIColor(colorLiteralRed: 0.623, green: 0.802, blue: 0.917, alpha: 1)
    ]
    
    // Settings for emitter in DarkTheme
    let snowEmitter: [String: Any] = [
        "emitterImage": #imageLiteral(resourceName: "snow"),
        "birthRate": Float(4),
        "lifetime": Float(17),
        "velocity": CGFloat(30),
        "scale": CGFloat(0.2),
        "scaleRange": CGFloat(0.06),
    ]
    
    // Settings for emitter in LightTheme
    let bubblesEmitter: [String: Any] = [
        "emitterImage": #imageLiteral(resourceName: "Bubbles"),
        "birthRate": Float(1.33),
        "lifetime": Float(15),
        "velocity": CGFloat(40),
        "scale": CGFloat(0.1),
        "scaleRange": CGFloat(0.09),
    ]
    
    // Property return current color style
    var currentStyle: [String: UIColor] {
        return UserDefaults.standard.value(forKey: "themeSwitcher") as! Bool ? darkTheme : lightTheme
    }
    
    // Property return current image for home screen
    var currentHomeImage: UIImage {
        return UserDefaults.standard.value(forKey: "themeSwitcher") as! Bool ? #imageLiteral(resourceName: "winterNight") : #imageLiteral(resourceName: "summerDay")
    }
    
    // Property return current image for emitting
    var currentImageForEmitting: UIImage {
        return UserDefaults.standard.value(forKey: "themeSwitcher") as! Bool ? (snowEmitter["emitterImage"] as! UIImage) : (bubblesEmitter["emitterImage"] as! UIImage)
    }
    
    // Property return current settings for emitter
    var currentEmitter: [String: Any] {
        return UserDefaults.standard.value(forKey: "themeSwitcher") as! Bool ? snowEmitter : bubblesEmitter
    }
}
