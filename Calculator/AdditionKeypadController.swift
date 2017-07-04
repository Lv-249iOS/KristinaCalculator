//
//  AdditionKeypadController.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 7/3/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class AdditionKeypadController: UIViewController {
    
    var onSymbolTap: ((_ button: UIButton)->())?
    
    @IBAction func onUtilitySymbolTap(_ button: UIButton) {
        onSymbolTap?(button)
    }
    
}
