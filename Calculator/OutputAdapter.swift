//
//  OutputAdapter.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 6/28/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class OutputAdapter: OutputProtocol {
    static let shared = OutputAdapter()
    
    var display: InfoPresentedController?
    
    func presentResult(result: String) {
        display?.present(value: result)
    }
    func presentOperand(operand: String) {
        display?.present(value: operand)
    }
}
