//
//  ScaleSegue.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 7/14/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class ScaleSegue: UIStoryboardSegue {
    
    override func perform() {
        scale()
    }
    
    func scale() {
        let currentViewController = self.source
        let destinationViewController = self.destination
        
        let containerView = currentViewController.view.superview
        let originalCenter = destinationViewController.view.center
        
        destinationViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        destinationViewController.view.center = originalCenter
        
        containerView?.addSubview(destinationViewController.view)
        
        UIView.animate(withDuration: 0.5, delay: 0, animations: {
            destinationViewController.view.transform = CGAffineTransform.identity
        }, completion: { success in
            currentViewController.present(destinationViewController, animated: false, completion: nil
            )
        })
    }

}
