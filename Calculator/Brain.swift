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
    var history: String!
    var temp: String = ""

    var countLeftBrackets: Int = 0
    var countRightBrackets: Int = 0

    
    func ResetProperties() {
        temp = ""
        countLeftBrackets = 0
        countRightBrackets = 0
    }
    
    // init string with equation
    func EnterEquation(equation: String) {
        while countLeftBrackets != countRightBrackets {
            temp = temp + " )"
            countRightBrackets += 1
        }
        
        history = equation
        self.equation = equation + temp
        process()
    }
    
    func presentHistory(currentInput: String?) {
        output.presentHistory(history: currentInput ?? "History")
    }
    
    
    func clear() {
        ResetProperties()
        equation = nil
        output.presentHistory(history: "history")
        output.presentResult(result: "0")
    }
    
    func equal() -> String {
        ResetProperties()
        output.presentHistory(history: "")
        equation = String(CalculateResult())
        output.presentResult(result: equation)
        
        return equation
    }

    // calc equation and present history
    func process() {
        output.presentHistory(history: history)
        output.presentResult(result: String(CalculateResult()))
    }
    
    // split String to [String]
    func parseInfix(_ equationStr: String) -> [String] {
        let tokens = equationStr.characters.split{ $0 == " " }.map(String.init)
        return tokens
    }
    
    func CalculateResult() -> Double {
        let rpnStr = ReverseToPolandNotation(tokens: parseInfix(equation)) // reverse to RPN
        var stack : [String] = [] // buffer for digit
        
        for tok in rpnStr {
            if Double(tok) != nil {
                stack += [tok]
                
            } else if tok == "sin" || tok == "cos" || tok == "ln" || tok == "√"{
                let operand = Double(stack.removeLast())
                
                switch tok {
                case "sin": stack += [String(sin(operand!))]
                case "cos": stack += [String(cos(operand!))]
                case "ln": stack += [String(log(operand!))]
                case "√": stack += [String(sqrt(operand!))]
                default: break
                    
                }
                
            } else {
                let secondOperand = Double(stack.removeLast())
                let firstOperand = Double(stack.removeLast())
                
                switch tok {
                case "+": stack += [String(firstOperand! + secondOperand!)]
                case "-": stack += [String(firstOperand! - secondOperand!)]
                case "÷": stack += [String(firstOperand! / secondOperand!)]
                case "×": stack += [String(firstOperand! * secondOperand!)]
                case "^": stack += [String(pow(firstOperand!,secondOperand!))]
                default: break
                    
                }
            }
        }
        
        return Double(stack.removeLast())!
    }

    func ReverseToPolandNotation(tokens: [String]) -> [String] {
        var rpn : [String] = [] // buffer for entire equation in RPN
        var stack : [String] = [] // buffer for operation

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
        
        return (rpn + stack.reversed())
    }
}
