//
//  StyleManager.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 7/10/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class StyleManager {
    static var shared = StyleManager()
    
    let lightTheme = [
        "backgroundColor": UIColor.init(colorLiteralRed: 0.952, green: 0.946, blue: 0.934, alpha: 1),
        "textColor": UIColor.black,
        "buttonColor": UIColor.init(colorLiteralRed: 0.974, green: 0.969, blue: 0.957, alpha: 1),
        "equal": UIColor.init(colorLiteralRed: 0.964, green: 0.652, blue: 0.350, alpha: 1)
    ]
    
    let darkTheme = [
        "backgroundColor": UIColor.init(colorLiteralRed: 0.133, green: 0.133, blue: 0.200, alpha: 1),
        "buttonColor": UIColor.init(colorLiteralRed: 0.173, green: 0.180, blue: 0.251, alpha: 1),
        "textColor": UIColor.white,
        "equal": UIColor.init(colorLiteralRed: 0.943, green: 0.182, blue: 0.361, alpha: 1)

    ]
        
}
