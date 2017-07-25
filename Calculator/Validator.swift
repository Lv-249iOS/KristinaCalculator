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
    
    /// This property that store validated equation
    static var Buffer: String! {
        set {
            newValue != "-inf" && newValue != "inf" && newValue != "nan" ? (buffer = newValue) : (buffer = nil)
        }
        get {
            return buffer
        }
    }
    
    /// This method checks num and bring it in the right format
    static func validateNum(_ num: Int) {
        if isEmpty() {
            buffer = String(num)
        } else if buffer.characters.last == "." || isLastInputDigit() ||
            (buffer.characters.count == 1 && (buffer.characters.last == "+" || buffer.characters.last == "-"))  {
            buffer = buffer + "\(num)"
        } else if buffer.characters.count >= 3, buffer.substring(from: buffer.index(buffer.endIndex, offsetBy: -3)) == "( -" {
            buffer = buffer + "\(num)"
        } else {
            buffer = buffer + " \(num)"
        }
    }
    
    /// This method checks plus and adds it in buffer equation if it possible
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
    
    /// This method checks minus and adds it in buffer equation if it possible
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
    
    /// This method checks dot and adds it in buffer equation if it possible
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
    
    /// This method checks multiply and adds it in buffer equation if it possible
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
    
    /// This method checks divition and adds it in buffer equation if it possible
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
    
    /// This method checks POW and adds it in buffer equation if it possible
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
    
    /// This method checks SQRT and adds it in buffer equation if it possible
    static func validateSqrt() {
        if isEmpty() {
            buffer = "√"
        } else if ifTypeWithSpace() {
            buffer = buffer + " × √"
        } else {
            buffer = buffer + " √"
        }
    }
    
    /// This method checks LN and adds it in buffer equation if it possible
    static func validateLog() {
        if isEmpty() {
            buffer = "ln ("
        } else if ifTypeWithSpace() {
            buffer = buffer + " × ln ("
        } else {
            buffer = buffer + " ln ("
        }
        Brain.shared.countLeftBrackets += 1
    }
    
    /// This method checks SIN and adds it in buffer equation if it possible
    static func validateSin() {
        if isEmpty() {
            buffer = "sin ("
        } else if ifTypeWithSpace() {
            buffer = buffer + " × sin ("
        } else {
            buffer = buffer + " sin ("
        }
        
        Brain.shared.countLeftBrackets += 1
    }
    
    /// This method checks COS and adds it in buffer equation if it possible
    static func validateCos() {
        if isEmpty() {
            buffer = "cos ("
        } else if ifTypeWithSpace() {
            buffer = buffer + " × cos ("
        } else {
            buffer = buffer + " cos ("
        }
        Brain.shared.countLeftBrackets += 1
    }
    
    /// This method checks Double.pi and adds it in buffer equation if it possible
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
    
    /// This method checks Left Bracket and adds it in buffer equation if it possible
    static func validateLeftBracket() {
        if isEmpty() {
            buffer = "("
        } else if ifTypeWithSpace() {
            buffer = buffer + " × ("
        } else {
            buffer = buffer + " ("
        }
        Brain.shared.countLeftBrackets += 1
    }
    
    /// This method checks Right Bracket and adds it in buffer equation if it possible
    static func validateRightBracket() {
        if Brain.shared.countLeftBrackets != 0 {
            if isLastInputDigit() ||
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
    
    /// This method checks if allowed press equal
    static func isAllowedPressEqual() -> Bool {
        return !(isEmpty() || (buffer.characters.count == 1 && !isLastInputDigit()))
    }
    
    /// Boolean method that return true if last input is digit or right brackets
    private static func ifTypeWithSpace() -> Bool {
        return buffer.characters.last == ")" || isLastInputDigit()
    }
    
    /// Boolean method that check symbol if it is digit
    private static func isLastInputDigit() -> Bool {
        return buffer.characters.last! >= "0" && buffer.characters.last! <= "9"
    }
    
    /// Boolean method that check buffer if it empty
    private static func isEmpty() -> Bool {
        return buffer == nil || buffer == "0" || buffer == ""
    }
}
