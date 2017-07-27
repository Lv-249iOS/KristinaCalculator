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
    
    func presentResult(result: String) {
        let preparedResult = result == "-0.0" ? "0" : String(format: "%g", Double(result) ?? 0.0)
        
        resultDisplay?(preparedResult)
    }
    
    func presentHistory(history: String) {
        historyDisplay?(history)
    }
}
