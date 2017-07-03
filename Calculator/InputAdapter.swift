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
        if buffer == nil || buffer == "0" {
            if symbol == "+" || symbol == "−" {
                buffer = symbol
            } else if symbol == "." {
                buffer = "0."
            } else if symbol == "(" {
                buffer = symbol
                brain.countLeftBrackets += 1
            } else if symbol == "sin" {
                buffer = symbol + " ("
                brain.countLeftBrackets += 1
            }
            
        } else if buffer.characters.count == 1 && (buffer.characters.last == "+" || buffer.characters.last == "−") {
            if symbol == "+" || symbol == "−" {
                buffer = symbol
            }
            
        } else if symbol == "." && buffer.characters.last != "." {
            if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
                buffer! += symbol
            } else {
                buffer = buffer + " 0\(symbol)"
            }
            
        } else if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
            if symbol == "(" {
                buffer = buffer + " * ("
                brain.countLeftBrackets += 1
            } else {
                buffer = buffer + " " + symbol
            }
            
        } else if symbol == "(" {
            buffer = buffer + " " + symbol
            brain.countLeftBrackets += 1
            
        } else if symbol == ")" {
            if brain.countLeftBrackets != 0 {
                if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" ||
                    (buffer.characters.last == ")" && brain.countLeftBrackets >= brain.countRightBrackets) {
                  
                    buffer = buffer + " )"
                } else {
                    buffer.characters.removeLast()
                    buffer = buffer + symbol
                }
                brain.countRightBrackets += 1
            }
            
        } else if buffer.characters.last == ")" {
            buffer = buffer + " " + symbol
            
        } else if symbol == "sin" {
            buffer = buffer + " " + symbol + " ("
            brain.countLeftBrackets += 1
            
        } else {   
            buffer.characters.removeLast()
            buffer = buffer + symbol
        }
        
        brain.presentHistory(currentInput: buffer)
    }
}

