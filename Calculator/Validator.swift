//
//  Validator.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 7/4/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class Validator {
    
    private static var buffer: String! = "0"

    static var Buffer: String! {
        set {
            newValue != "-inf" && newValue != "inf" && newValue != "nan" ? (buffer = newValue) : (buffer = nil)
        }
        get {
            return buffer
        }
    }

    static func validateNum(_ num: Int) {
        if isEmpty() {
            buffer = String(num)
        } else if buffer.characters.last == "." || isLastInputDigit() ||
            (buffer.characters.count == 1 && (buffer.characters.last == "+" || buffer.characters.last == "-"))  {
            buffer = buffer + "\(num)"
        } else if buffer.characters.count >= 3, buffer.substring(from: buffer.index(buffer.endIndex, offsetBy: -3)) == "( -" {
            buffer = buffer + "\(num)"
        } else if buffer.characters.last == ")" {
            buffer = buffer + " × \(num)"
        } else {
            buffer = buffer + " \(num)"
        }
    }

    static func validatePls() {
        if isEmpty() || buffer.characters.count == 1 && buffer.characters.last == "-" {
            buffer = "+"
        } else if ifTypeWithSpace() || buffer.characters.last == "." {
            buffer = buffer + " +"
        } else if buffer.characters.last != "(" {
            buffer.characters.removeLast()
            buffer = buffer + "+"
        }
    }

    static func validateMns() {
        if isEmpty() || buffer.characters.count == 1 && buffer.characters.last == "+" {
            buffer = "-"
        } else if ifTypeWithSpace() || buffer.characters.last == "(" {
            buffer = buffer + " -"
        } else if buffer.characters.last != "(" {
            buffer.characters.removeLast()
            buffer = buffer + "-"
        }
    }

    static func validateDot() {
        if isEmpty() {
            buffer = "0."
        } else if buffer.characters.last != "." {
            if isLastInputDigit() {
                buffer! += "."
            } else if buffer.characters.last == "(" {
                buffer = buffer + " 0."
            }
        }
    }

    static func validateMul() {
        if buffer != nil && buffer.characters.count >= 1 {
            if ifTypeWithSpace() || buffer.characters.last == "." {
                buffer = buffer + " ×"
            } else if buffer.characters.last != "(" && buffer != "+" && buffer != "-" {
                buffer.characters.removeLast()
                buffer = buffer + "×"
            }
        }
    }

    static func validateDiv() {
        if buffer != nil && buffer.characters.count >= 1 {
            if ifTypeWithSpace() {
                buffer = buffer + " ÷"
            } else if buffer.characters.last != "(" && buffer != "+" && buffer != "-" {
                buffer.characters.removeLast()
                buffer = buffer + "÷"
            }
        }
    }
    
    static func validatePow() {
        if buffer != nil && buffer != "0" && buffer.characters.count >= 1 {
            if ifTypeWithSpace() || buffer.characters.last == "." {
                buffer = buffer + " ^"
            } else if buffer.characters.last != "(" {
                buffer.characters.removeLast()
                buffer = buffer + "^"
            }
        }
    }
    
    static func validateSqrt() {
        if isEmpty() {
            buffer = "√"
        } else if ifTypeWithSpace() {
            buffer = buffer + " × √"
        } else {
            buffer = buffer + " √"
        }
    }
    
    static func validateLog() {
        if isEmpty() {
            buffer = "ln ("
        } else if ifTypeWithSpace() {
            buffer = buffer + " × ln ("
        } else {
            buffer = buffer + " ln ("
        }
        input.countLeftBrackets += 1
    }
    
    static func validateSin() {
        if isEmpty() {
            buffer = "sin ("
        } else if ifTypeWithSpace() {
            buffer = buffer + " × sin ("
        } else {
            buffer = buffer + " sin ("
        }
        
        input.countLeftBrackets += 1
    }
    
    static func validateCos() {
        if isEmpty() {
            buffer = "cos ("
        } else if ifTypeWithSpace() {
            buffer = buffer + " × cos ("
        } else {
            buffer = buffer + " cos ("
        }
        input.countLeftBrackets += 1
    }
    
    static func validatePi() {
        if isEmpty() {
            buffer = "\(Double.pi)"
        } else if ifTypeWithSpace() {
            buffer = buffer + " × \(Double.pi)"
        }  else if isLastInputDigit() ||
            buffer.characters.count == 1 && buffer.characters.last == "-" ||
            (buffer.characters.count >= 3 && buffer.substring(from: buffer.index(buffer.endIndex, offsetBy: -3)) == "( -") {
            buffer = buffer + "\(Double.pi)"
        } else if buffer.characters.last != "." {
            buffer = buffer + " \(Double.pi)"
        }
    }
    
    static func validateLeftBracket() {
        if isEmpty() {
            buffer = "("
        } else if ifTypeWithSpace() {
            buffer = buffer + " × ("
        } else {
            buffer = buffer + " ("
        }
        input.countLeftBrackets += 1
    }
    
    static func validateRightBracket() {
        if input.countLeftBrackets != 0 {
            if isLastInputDigit() ||
                (buffer.characters.last == ")" && input.countLeftBrackets > input.countRightBrackets) {
                buffer = buffer + " )"
                input.countRightBrackets += 1
            } else if !(buffer.characters.last == "(") {
                buffer.characters.removeLast()
                buffer = buffer + ")"
                input.countRightBrackets += 1
            }
        }
    }
    
    static func isAllowedPressEqual() -> Bool {
        return !(isEmpty() || (buffer.characters.count == 1 && !isLastInputDigit()))
    }
    
    private static func ifTypeWithSpace() -> Bool {
        return buffer.characters.last == ")" || isLastInputDigit()
    }
    
    private static func isLastInputDigit() -> Bool {
        return buffer.characters.last! >= "0" && buffer.characters.last! <= "9"
    }
    
    private static func isEmpty() -> Bool {
        return buffer == nil || buffer == "0" || buffer == ""
    }
}
