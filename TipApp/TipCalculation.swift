//
//  TipCalculation.swift
//  TipApp
//
//  Created by Brandon Dowless on 3/22/22.
//

import Foundation

struct TipCalculation {
    var tipPercentage: Double
    var numberOfPeople: Int = 1
    
    func billTotal(forAmount amount: Double) -> Double {
        return amount + (amount * (tipPercentage / 100)) / Double(numberOfPeople)
    }
}
