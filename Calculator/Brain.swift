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
    var history: String?

    var countLeftBrackets: Int = 0
    var countRightBrackets: Int = 0

    func resetProperties() {
        countLeftBrackets = 0
        countRightBrackets = 0
    }
    
    func addMissedRightBrackets(_ equation: String) -> String {
        var missingBrackets: String = ""
        var counter = countRightBrackets
        
        while countLeftBrackets > counter {
            missingBrackets = missingBrackets + " )"
            counter += 1
        }
        
        return equation + missingBrackets
    }
    
    func enterEquation(equation: String) {
        self.history = equation
        self.equation = addMissedRightBrackets(equation)
        process()
    }
    
    func presentHistory(currentInput: String?) {
        output.presentHistory(history: currentInput ?? "")
    }
    
    func clear() {
        resetProperties()
        equation = nil
        output.presentHistory(history: "")
        output.presentResult(result: "0")
    }
    
    func equal() -> String {
        resetProperties()
        equation = String(format: "%g", calculateResult())
        
        if equation == "-0" {
            equation = "0"
        }
        
        output.presentResult(result: equation)
        output.presentHistory(history: "")
        
        return equation
    }

    func process() {
        let result = calculateResult()
        
        result != -0.0 ? (output.presentResult(result: String(format: "%g", result))) : (output.presentResult(result: String(format: "%g", 0)))
        presentHistory(currentInput: history)
    }
    
    func parseInfix(_ equationStr: String) -> [String] {
        let tokens = equationStr.characters.split{ $0 == " " }.map(String.init)
        return tokens
    }
    
    func calculateResult() -> Double {
        let rpnStr = reverseToPolandNotation(tokens: parseInfix(equation)) // reverse to RPN
        var stack : [String] = [] // buffer for digit
        
        for tok in rpnStr {
            if Double(tok) != nil  {
                stack += [tok]
                
            } else if !stack.isEmpty && (tok == "sin" || tok == "cos" || tok == "ln" || tok == "√") {
                if let operand = Double((stack.removeLast())) {
                    switch tok {
                    case "sin":
                        stack += [String(sin(operand))]
                    case "cos":
                        stack += [String(cos(operand))]
                    case "ln":
                        stack += [String(log(operand))]
                    case "√":
                        stack += [String(sqrt(operand))]
                    default:
                        break
                    }
                }
                
            } else {
                if stack.count > 1 {
                    if let secondOperand = Double(stack.removeLast()), let firstOperand = Double(stack.removeLast()) {
                        switch tok {
                        case "+":
                            stack += [String(firstOperand + secondOperand)]
                        case "-":
                            stack += [String(firstOperand - secondOperand)]
                        case "÷":
                            stack += [String(firstOperand / secondOperand)]
                        case "×":
                            stack += [String(firstOperand * secondOperand)]
                        case "^":
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
            "^": 4,
            "√" : 5,
            "×" : 3,
            "÷" : 3,
            "+" : 2,
            "-" : 2,
            "ln" : 4,
            "sin" : 5,
            "cos" : 5,
        ]
        
        // loop take 1 element and put on the right place and drop brackets 
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
                        rpn += [op] }
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
