//
//  InfoPresentedController.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 6/28/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class InfoPresentedController: UIViewController {

    @IBOutlet var displayLabel: UILabel!
    @IBOutlet var historyLabel: UILabel!
    
    let output = OutputAdapter.shared
    
    func presentResult(_ result: String) {
        displayLabel.text = result
    }
    
    func presentHistory(_ history: String) {
        historyLabel.text = history
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.display = self
    }

}
