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
        if buffer == nil {
            buffer = String(number)
        } else {
            buffer = buffer + " \(number)"
        }

        brain.EnterEquation(equation: buffer)
    }
    
    func enterUtility(_ symbol: String) {
        if buffer != nil {
            if symbol == "+" || symbol == "-" {
                buffer = symbol
            } else if symbol == "." {
                buffer = "0."
            }
        } else if buffer.characters.last == "+" || buffer.characters.last == "-" {
            if buffer.characters.count == 1 && (symbol == "+" || symbol == "-") {
                buffer = symbol
            } else {
                buffer.characters.removeLast()
                buffer = symbol
            }
        } else if symbol == "." && buffer.characters.last != "." {
            buffer! += symbol
        } else {
            buffer = buffer + " \(symbol)"
        }
    }
}
