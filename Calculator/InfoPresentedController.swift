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
    @IBOutlet weak var scrollView: UIScrollView!
    
    let output = OutputAdapter.shared
    
    func presentResult(_ result: String) {
        displayLabel.text = result
    }
    
    func presentHistory(_ history: String) {
        historyLabel.text = history
        scrollView.scrollRectToVisible(historyLabel.bounds, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.historyDisplay = { [weak self] history in
            self?.presentHistory(history)
        }
        
        output.resultDisplay = { [weak self] result in
            self?.presentResult(result)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeTheme), name: CHANGE_STYLE_COLOR, object: nil)
    }
    
    func changeTheme() {
        if UserDefaults.standard.value(forKey: "themeSwitcher") as! Bool {
            displayLabel.backgroundColor = StyleManager.shared.lightTheme["backgroundColor"]
            historyLabel.backgroundColor = StyleManager.shared.lightTheme["backgroundColor"]
            displayLabel.textColor = StyleManager.shared.lightTheme["textColor"]
            historyLabel.textColor = StyleManager.shared.lightTheme["textColor"]
        } else {
            displayLabel.backgroundColor = StyleManager.shared.darkTheme["backgroundColor"]
            historyLabel.backgroundColor = StyleManager.shared.darkTheme["backgroundColor"]
            displayLabel.textColor = StyleManager.shared.darkTheme["textColor"]
            historyLabel.textColor = StyleManager.shared.darkTheme["textColor"]
        }
    }

}
