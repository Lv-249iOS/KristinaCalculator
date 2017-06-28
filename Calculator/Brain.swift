//
//  Brain.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 6/28/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class Brain: Model {
    static let shared = Brain()
    let output = OutputAdapter.shared
    var operand: String = ""

    
    func process() {
        //....
        output.presentResult(result: operand)
    }
    
    func inputOperand(_ digit: Int) {
        operand += "\(digit)"
        process()
    }
    func inputOperation(operation: String) {

    }
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(Double.pi),
        "e" : Operation.Constant(M_E),
        "±" : Operation.UnaryOperation({ -$0 }),
        "cos" : Operation.UnaryOperation({ cos($0) }),
        "sin" : Operation.UnaryOperation({ sin($0) }),
        "√" : Operation.UnaryOperation({ sqrt($0) }),
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "−" : Operation.BinaryOperation({ $0 - $1 }),
        "×" : Operation.BinaryOperation({ $0 * $1 }),
        "÷" : Operation.BinaryOperation({ $0 / $1 }),
        "=" : Operation.Equals,
        ]

    
}
