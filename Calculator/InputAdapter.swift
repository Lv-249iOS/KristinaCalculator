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
    var buffer: String!
    
    func enterNum(_ number: Int) {
        if buffer == nil || buffer == "0" {
            buffer = String(number)
            
        } else if buffer.characters.last == "." || buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
            buffer = buffer + "\(number)"
            
        } else if buffer.characters.count == 1 && (buffer.characters.last == "+" || buffer.characters.last == "-")  {
            buffer = buffer + "\(number)"
        } else {
            buffer = buffer + " \(number)"
            
        }
        
        brain.EnterEquation(equation: buffer)
    }
    
    // 10001 - equalButton 10002 - clear button
    func enterServiceKey(_ serviceKey: Int) {
        if serviceKey == 10001 {
            buffer = brain.equal()
        } else {
            buffer = nil
            brain.clear()
        }
    }
    
    func enterUtility(_ symbol: String) {
        switch symbol {
        case "+" : validatePls()
        case "-" : validateMns()
        case "×" : validateMul()
        case "÷" : validateDiv()
        case "^" : validatePow()
        case "." : validateDot()
        case "(" : validateLeftBracket()
        case ")" : validateRightBracket()
        case "√" : validateSqrt()
        case "ln" : validateLog()
        case "sin" : validateSin()
        case "cos" : validateCos()
        default: break
        }
        
        brain.presentHistory(currentInput: buffer)
    }
    
    // =======================
    
    func validatePls() {
        if buffer == nil || buffer == "0" || buffer.characters.count == 1 && buffer.characters.last == "-" {
            buffer = "+"
        } else if buffer.characters.last == ")" {
            buffer = buffer + " +"
            
        } else if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
            buffer = buffer + " +"
        } else {
            buffer.characters.removeLast()
            buffer = buffer + "+"
        }
    }
        
    func validateMns() {
        if buffer == nil || buffer == "0" || buffer.characters.count == 1 && buffer.characters.last == "+" {
            buffer = "-"
        } else if buffer.characters.last == ")" {
            buffer = buffer + " )"
            
        } else if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
            buffer = buffer + " -"
        } else {
            buffer.characters.removeLast()
            buffer = buffer + "-"
        }
    }
        
    func validateDot() {
        if buffer == nil || buffer == "0" {
            buffer = "0."
        } else if buffer.characters.last != "." {
            if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
                buffer! += "."
            } else {
                buffer = buffer + " 0."
            }
        }
    }
    
        
     func validateMul() {
        if buffer != nil && buffer.characters.count > 1 {
            if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
                buffer = buffer + " ×"
            } else if buffer.characters.last == ")" {
                buffer = buffer + " ×"
                
            } else {
                buffer.characters.removeLast()
                buffer = buffer + "×"
            }
        }
    }
        
    func validateDiv() {
        if buffer != nil && buffer.characters.count > 1 {
            if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
                buffer = buffer + " ÷"
            } else if buffer.characters.last == ")" {
                buffer = buffer + " ÷"
                
            } else {
                buffer.characters.removeLast()
                buffer = buffer + "÷"
            }
        }
    }

        
    func validatePow() {
        if (buffer != nil && buffer != "0") && buffer.characters.count >= 1 {
            if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
                buffer = buffer + " ^"
            } else if buffer.characters.last == ")" {
                buffer = buffer + " ^"
                
            } else {
                buffer.characters.removeLast()
                buffer = buffer + "^"
            }
        }
    }
        
    func validateSqrt() {
            buffer == nil || buffer == "0" ? (buffer = "√") : (buffer = buffer + " √")
        }
    
    func validateLog() {
        buffer == nil || buffer == "0" ? (buffer = "ln (") : (buffer = buffer + " ln (")
        brain.countLeftBrackets += 1
    }
    
    func validateSin() {
        buffer == nil || buffer == "0" ? (buffer = "sin (") : (buffer = buffer + " sin (")
        brain.countLeftBrackets += 1
    }
    
    func validateCos() {
        buffer == nil || buffer == "0" ? (buffer = "cos (") : (buffer = buffer + " cos (")
        brain.countLeftBrackets += 1
    }
    
    func validateLeftBracket() {
        if buffer == nil || buffer == "0" {
            buffer = "("
            brain.countLeftBrackets += 1
        } else if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
            buffer = buffer + " × ("
            brain.countLeftBrackets += 1
        } else {
            buffer = buffer + " ("
            brain.countLeftBrackets += 1
        }
    }

    func validateRightBracket() {
        if brain.countLeftBrackets != 0 {
            if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" ||
                (buffer.characters.last == ")" && brain.countLeftBrackets > brain.countRightBrackets) {
                
                buffer = buffer + " )"
                brain.countRightBrackets += 1
            } else {
                buffer.characters.removeLast()
                buffer = buffer + ")"
                brain.countRightBrackets += 1
            }
        }
    }
    
}
