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
    
    /// This method transfers digit to equation
    func enterNum(_ number: Int) {
        Validator.validateNum(number)
        brain.enterEquation(equation: Validator.Buffer)
    }
    
    /// This method transfer utility symbols to equation
    func enterUtility(_ symbol: Operation) {
        switch symbol {
        case .pls:
            Validator.validatePls()
        case .mns:
            Validator.validateMns()
        case .mul:
            Validator.validateMul()
        case .div:
            Validator.validateDiv()
        case .pow:
            Validator.validatePow()
        case .dot:
            Validator.validateDot()
        case .log:
            Validator.validateLog()
        case .sin:
            Validator.validateSin()
        case .cos:
            Validator.validateCos()
        case .sqrt:
            Validator.validateSqrt()
        case .leftBracket:
            Validator.validateLeftBracket()
        case .rightBracket:
            Validator.validateRightBracket()
        case .pi:
            Validator.validatePi()
            brain.enterEquation(equation: Validator.Buffer)
        case .clear:
            Validator.Buffer = nil
            brain.clear()
        case .equal:
            if Validator.isAllowedPressEqual() {
                Validator.Buffer = brain.equal()
            }
        default:
            break
        }

        if .equal != symbol {
            brain.presentHistory(currentInput: Validator.Buffer)
        }
    }    
}


