//
//  ProgramNavigationController.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 7/11/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class ProgramNavigationController: UIViewController {
    
    @IBOutlet weak var imageBackground: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        NotificationCenter.default.addObserver(self, selector: #selector(setTheme), name: kChangeStyleColor, object: nil)
    }
    
    func setTheme() {
        if UserDefaults.standard.value(forKey: "themeSwitcher") as! Bool {
            self.view.backgroundColor = StyleManager.shared.darkTheme["backgroundColor"]
            imageBackground.image = #imageLiteral(resourceName: "winterNight")
        } else {
             self.view.backgroundColor = StyleManager.shared.lightTheme["backgroundColor"]
            imageBackground.image = #imageLiteral(resourceName: "summerDay")
        }
    }
}
