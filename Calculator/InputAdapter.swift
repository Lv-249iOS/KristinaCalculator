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
    
    func enterNum(_ number: Int) {
        Validator.validateNum(number)
        brain.EnterEquation(equation: Validator.Buffer)
    }
    
    func enterServiceKey(_ serviceKey: Int) {
        switch serviceKey {
        case 10013: Validator.Buffer = brain.equal()
        case 10014: Validator.Buffer = nil; brain.clear()
        default: break;
        
        }
    }
    
    func enterUtility(_ symbol: String) {
        switch symbol {
        case "+" : Validator.validatePls()
        case "-" : Validator.validateMns()
        case "×" : Validator.validateMul()
        case "÷" : Validator.validateDiv()
        case "^" : Validator.validatePow()
        case "." : Validator.validateDot()
        case "(" : Validator.validateLeftBracket()
        case ")" : Validator.validateRightBracket()
        case "√" : Validator.validateSqrt()
        case "ln" : Validator.validateLog()
        case "sin" : Validator.validateSin()
        case "cos" : Validator.validateCos()
        default: break
        
        }
        
        brain.presentHistory(currentInput: Validator.Buffer)
    }

}
