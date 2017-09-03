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
    
    var countLeftBrackets: Int = 0
    var countRightBrackets: Int = 0
    
    func enterNum(_ number: Int) {
        Validator.validateNum(number)
        brain.missedBrackets = missedRightBrackets()
        brain.enterEquation(equation: Validator.Buffer)
    }
    
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
            resetProperties()
            Validator.Buffer = nil
            brain.clear()
        case .equal:
            resetProperties()
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
    
    func resetProperties() {

        countLeftBrackets = 0
        countRightBrackets = 0
    }
    
    func missedRightBrackets() -> String {
        var missingBrackets: String = ""
        var counter = countRightBrackets
        
        while countLeftBrackets > counter {
            missingBrackets = missingBrackets + " )"
            counter += 1
        }
        
        return missingBrackets
    }
}


