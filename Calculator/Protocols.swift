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
    func enterUtility(_ symbol: Int)
}

protocol OutputProtocol {
    func presentResult(result: String)
}

protocol Model {
    func inputOperand(_ digit: Int)
    func inputOperation(operation: String)
}
