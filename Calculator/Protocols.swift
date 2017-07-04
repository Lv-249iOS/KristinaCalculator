//
//  Protocols.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 6/28/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

protocol InputProtocol {
    func enterNum(_ number: Int)
    func enterUtility(_ symbol: String)
}

protocol OutputProtocol {
    func presentResult(result: String)
}

protocol Model {
    func EnterEquation(equation: String)
}

let operation = [
    "^": (prec: 4, rAssoc: true),
    "√": (prec: 5, rAssoc: true),
    "×": (prec: 3, rAssoc: false),
    "÷": (prec: 3, rAssoc: false),
    "+": (prec: 2, rAssoc: false),
    "−": (prec: 2, rAssoc: false),
    "sin": (prec: 5, rAssoc: true),
    "cos": (prec: 5, rAssoc: true),
    "log": (prec: 4, rAssoc: true),
]
