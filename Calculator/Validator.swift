//
//  Validator.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 7/4/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class Validator {
    private static var buffer: String!
    static var Buffer: String! { set { self.buffer = newValue } get { return self.buffer } }
    
    static func validateNum(_ num: Int) {
        if buffer == nil || buffer == "0" {
            buffer = String(num)
        } else if buffer.characters.last == "." || buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
            buffer = buffer + "\(num)"
            
        } else if buffer.characters.count == 1 && (buffer.characters.last == "+" || buffer.characters.last == "-")  {
            buffer = buffer + "\(num)"
        } else {
            buffer = buffer + " \(num)"
        }
    }
    
    static func validatePls() {
        if buffer == nil || buffer == "0" || buffer.characters.count == 1 && buffer.characters.last == "-" {
            buffer = "+"
        } else if buffer.characters.last == ")" {
            buffer = buffer + " +"
            
        } else if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
            buffer = buffer + " +"
        } else if buffer.characters.last != "(" {
            buffer.characters.removeLast()
            buffer = buffer + "+"
        }
    }
    
    static func validateMns() {
        if buffer == nil || buffer == "0" || buffer.characters.count == 1 && buffer.characters.last == "+" {
            buffer = "-"
        } else if buffer.characters.last == ")" {
            buffer = buffer + " -"
            
        } else if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
            buffer = buffer + " -"
        } else if buffer.characters.last != "(" {
            buffer.characters.removeLast()
            buffer = buffer + "-"
        }
    }
    
    static func validateDot() {
        if buffer == nil || buffer == "0" {
            buffer = "0."
        } else if buffer.characters.last != "." {
            if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
                buffer! += "."
            } else if buffer.characters.last != "(" {
                buffer = buffer + " 0."
            }
        }
    }
    
    static func validateMul() {
        if buffer != nil && buffer.characters.count > 1 {
            if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
                buffer = buffer + " ×"
            } else if buffer.characters.last == ")" {
                buffer = buffer + " ×"
                
            } else if buffer.characters.last != "(" {
                buffer.characters.removeLast()
                buffer = buffer + "×"
            }
        }
    }
    
    static func validateDiv() {
        if buffer != nil && buffer.characters.count > 1 {
            if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
                buffer = buffer + " ÷"
            } else if buffer.characters.last == ")" {
                buffer = buffer + " ÷"
                
            } else if buffer.characters.last != "(" {
                buffer.characters.removeLast()
                buffer = buffer + "÷"
            }
        }
    }
    
    static func validatePow() {
        if (buffer != nil && buffer != "0") && buffer.characters.count >= 1 {
            if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
                buffer = buffer + " ^"
            } else if buffer.characters.last == ")" {
                buffer = buffer + " ^"
                
            } else if buffer.characters.last != "(" {
                buffer.characters.removeLast()
                buffer = buffer + "^"
            }
        }
    }
    
    static func validateSqrt() {
        if buffer == nil || buffer == "0" {
            buffer = "√"
        } else if buffer.characters.last == ")" {
            buffer = buffer + " × √"
        } else {
            buffer = buffer + " √"
        }
    }
    
    static func validateLog() {
        if buffer == nil || buffer == "0" {
            buffer = "ln ("
        } else if buffer.characters.last == ")" {
            buffer = buffer + " × ln ("
        } else {
            buffer = buffer + " ln ("
        }
        Brain.shared.countLeftBrackets += 1
    }
    
    static func validateSin() {
        if buffer == nil || buffer == "0" {
            buffer = "sin ("
        } else if buffer.characters.last == ")" {
            buffer = buffer + " × sin ("
        } else {
            buffer = buffer + " sin ("
        }
        
        Brain.shared.countLeftBrackets += 1
    }
    
    static func validateCos() {
        if buffer == nil || buffer == "0" {
            buffer = "cos ("
        } else if buffer.characters.last == ")" {
            buffer = buffer + " × cos ("
        } else {
            buffer = buffer + " cos ("
        }
        Brain.shared.countLeftBrackets += 1
    }
    
    static func validatePi() {
        if buffer == nil || buffer == "0" {
            buffer = "\(Double.pi)"
        } else if buffer.characters.last == ")" {
            buffer = buffer + " × \(Double.pi)"
        } else if buffer.characters.last != "." {
            buffer = buffer + " \(Double.pi)"
        }
    }
    
    static func validateLeftBracket() {
        if buffer == nil || buffer == "0" {
            buffer = "("
            Brain.shared.countLeftBrackets += 1
        } else if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" || buffer.characters.last! == ")" {
            buffer = buffer + " × ("
            Brain.shared.countLeftBrackets += 1
        } else {
            buffer = buffer + " ("
            Brain.shared.countLeftBrackets += 1
        }
    }
    
    static func validateRightBracket() {
        if Brain.shared.countLeftBrackets != 0 {
            if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" ||
                (buffer.characters.last == ")" && Brain.shared.countLeftBrackets > Brain.shared.countRightBrackets) {
                buffer = buffer + " )"
                Brain.shared.countRightBrackets += 1
            } else if !(buffer.characters.last == "(") {
                buffer.characters.removeLast()
                buffer = buffer + ")"
                Brain.shared.countRightBrackets += 1
            }
        }
    }
}
