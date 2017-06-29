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
    var equation: String!
    var result: String?


    
    func EnterEquation(equation: String) {
        self.equation = equation
        process()
    }
    
    func CalculateResult() -> Double {
        let tokens = equation?.characters.split{ $0 == " " }.map(String.init)
        var stack = [Double]()
        
        for tok in tokens! {
            if let tokenNum = Double(tok) {
                stack.append(tokenNum)
            } else {
                // pop 1 pop 2 
                // calc 1 and 2 
                // push
            }
        
        }
        return stack[0]
    }
    
    
    func process() {
        output.presentHistory(history: equation ?? "0.0")
        //output.presentResult(result: String(CalculateResult()))
        output.presentResult(result: equation ?? "0.0")
        
    }
    
    func ReverseToPolandNotation(tokens: [String]) -> [String] {
        var rpn : [String] = []
        var stack : [String] = []
        for tok in tokens {
            switch tok {
            case "(":
                stack += [tok]
            case ")":
                while !stack.isEmpty {
                    let op = stack.removeLast()
                    if op == "(" {
                        break
                    } else {
                        rpn += [op]
                    }
                }
            default:
                if let operand1 = operation[tok] {
                    for op in stack.reversed() {
                        if let operand2 = operation[op] {
                            if !(operand1.prec > operand2.prec || (operand1.prec == operand2.prec && operand1.rAssoc)) {
                                rpn += [stack.removeLast()]
                                continue
                            }
                        }
                        break
                    }
                    stack += [tok]
                } else { 
                    rpn += [tok] 
                }
            }
        }
        return rpn + stack.reversed()
    }
    
    let operation = [
        "^": (prec: 4, rAssoc: true),
        "*": (prec: 3, rAssoc: false),
        "/": (prec: 3, rAssoc: false),
        "+": (prec: 2, rAssoc: false),
        "-": (prec: 2, rAssoc: false),
    ]
    

}
