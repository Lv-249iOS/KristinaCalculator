//
//  InputAdapter.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 6/28/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class IntputAdapter: InputProtocol {
    static let shared = IntputAdapter()
    let brain = Brain.shared
    
    private var isTyping = false
    private var isDotTouched = false
    private var digit: String?
    
    func enterNum(_ number: Int) {
        brain.inputOperand(number)
    }
    
    // gggggggg
    func enterUtility(_ symbol: Int) {
        
    }
}
