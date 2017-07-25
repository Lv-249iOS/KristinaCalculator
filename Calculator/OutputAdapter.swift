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

    var resultDisplay: ((String)->())?
    var historyDisplay: ((String)->())?
    
    /// This methods presents result of equation
    func presentResult(result: String) {
        resultDisplay?(result)
    }
    
    /// This methods presents history of input
    func presentHistory(history: String) {
        historyDisplay?(history)
    }
}
