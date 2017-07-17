//
//  InfoPresentedController.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 6/28/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

/// Class controls presentation of history and result of calculation
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

        setTheme()
    }
    
    func setTheme() {
        displayLabel.backgroundColor = style.currentStyle["backgroundColor"]
        historyLabel.backgroundColor = style.currentStyle["backgroundColor"]
        scrollView.backgroundColor = style.currentStyle["backgroundColor"]
        displayLabel.textColor = style.currentStyle["textColor"]
        historyLabel.textColor = style.currentStyle["textColor"]
    }
}
