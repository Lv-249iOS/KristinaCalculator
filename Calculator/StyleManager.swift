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
    
    let lightTheme = [
        "backgroundColor": UIColor(colorLiteralRed: 0.952, green: 0.946, blue: 0.934, alpha: 1),
        "textColor": UIColor(colorLiteralRed: 0.273, green: 0.135, blue: 0.092, alpha: 1),
        "buttonColor": UIColor(colorLiteralRed: 0.974, green: 0.969, blue: 0.957, alpha: 1),
        "UtilitybuttonColor": UIColor(colorLiteralRed: 0.867, green: 0.864, blue: 0.855, alpha: 1),
        "equal": UIColor(colorLiteralRed: 0.964, green: 0.652, blue: 0.350, alpha: 1)
    ]
    
    let darkTheme = [
        "backgroundColor": UIColor(colorLiteralRed: 0.000, green: 0.047, blue: 0.073, alpha: 1),
        "buttonColor": UIColor(colorLiteralRed: 0.000, green: 0.083, blue: 0.128, alpha: 1),
        "UtilitybuttonColor": UIColor(colorLiteralRed: 0.000, green: 0.215, blue: 0.331, alpha: 1),
        "textColor": UIColor.white,
        "equal": UIColor(colorLiteralRed: 0.623, green: 0.802, blue: 0.917, alpha: 1)
    ]        
}
