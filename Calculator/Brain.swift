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
    var equation: String?
    var history: String?
    var missedBrackets: String?

    func enterEquation(equation: String) {
        self.history = equation
        self.equation = equation + (missedBrackets ?? "")
        process()
    }
    
    func presentHistory(currentInput: String?) {
        output.presentHistory(history: currentInput ?? "")
    }
    
    func clear() {
        missedBrackets = nil
        equation = nil
        output.presentHistory(history: "")
        output.presentResult(result: "0")
    }
    
    func equal() -> String {
        missedBrackets = nil
        equation = String(format: "%g", calculateResult())

        output.presentResult(result: equation ?? "")
        output.presentHistory(history: "")
        
        return equation ?? ""
    }

    func process() {
        let result = calculateResult()
        
        output.presentResult(result: String(result))
        presentHistory(currentInput: history)
    }
    
    func parseInfix(_ equationStr: String) -> [String] {
        let tokens = equationStr.characters.split{ $0 == " " }.map(String.init)
        return tokens
    }
    
    func calculateResult() -> Double {
        let rpnStr = reverseToPolandNotation(tokens: parseInfix(equation ?? "")) // reverse to RPN
        var stack : [String] = [] // buffer for digit
        
        for tok in rpnStr {
            if Double(tok) != nil  {
                stack += [tok]
                
            } else if !stack.isEmpty && (tok == MathOperation.sin.rawValue || tok == MathOperation.cos.rawValue || tok == MathOperation.ln.rawValue || tok == MathOperation.sqrt.rawValue) {
                if let operand = Double((stack.removeLast())) {
                    switch tok {
                    case MathOperation.sin.rawValue:
                        stack += [String(sin(operand))]
                    case MathOperation.cos.rawValue:
                        stack += [String(cos(operand))]
                    case MathOperation.ln.rawValue:
                        stack += [String(log(operand))]
                    case MathOperation.sqrt.rawValue:
                        stack += [String(sqrt(operand))]
                    default:
                        break
                    }
                }
            } else {
                if stack.count > 1 {
                    if let secondOperand = Double(stack.removeLast()), let firstOperand = Double(stack.removeLast()) {
                        switch tok {
                        case MathOperation.pls.rawValue:
                            stack += [String(firstOperand + secondOperand)]
                        case MathOperation.mns.rawValue:
                            stack += [String(firstOperand - secondOperand)]
                        case MathOperation.div.rawValue:
                            stack += [String(firstOperand / secondOperand)]
                        case MathOperation.mul.rawValue:
                            stack += [String(firstOperand * secondOperand)]
                        case MathOperation.pow.rawValue:
                            stack += [String(pow(firstOperand,secondOperand))]
                        default:
                            break
                        }
                    }
                } else {
                    history = "ERROR"
                    return 0.0
                }
            }
        }
        
        return Double(stack.removeLast())!
    }

    
    func reverseToPolandNotation(tokens: [String]) -> [String] {
        var rpn : [String]   = [] // buffer for entire equation in RPN
        var stack : [String] = [] // buffer for operation

        // dictionary with precedence of operation
        let operationPrec: Dictionary<String, Int> = [
            MathOperation.pow.rawValue: 4,
            MathOperation.sqrt.rawValue: 5,
            MathOperation.mul.rawValue: 3,
            MathOperation.div.rawValue: 3,
            MathOperation.pls.rawValue: 2,
            MathOperation.mns.rawValue: 2,
            MathOperation.ln.rawValue: 4,
            MathOperation.sin.rawValue: 5,
            MathOperation.cos.rawValue: 5,
        ]
        
        // loop take 1 element and put on the right place and drop brackets 
        for tok in tokens {
            switch tok {
            case MathOperation.bracketL.rawValue:
                stack += [tok]
            case MathOperation.bracketR.rawValue:
                while !stack.isEmpty {
                    let op = stack.removeLast()
                    if op == MathOperation.bracketL.rawValue {
                        break
                    } else {
                        rpn += [op]
                    }
                }
            default:
                if let operand1 = operationPrec[tok] {
                    for op in stack.reversed() {
                        if let operand2 = operationPrec[op], !(operand1 > operand2) {
                            rpn += [stack.removeLast()]
                            continue
                        }
                        break
                    }
                    stack += [tok]
                } else { 
                    rpn += [tok]
                }
            }
        }
        
        return (rpn + stack.reversed())
    }
}
