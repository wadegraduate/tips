//
//  CalculationViewModel.swift
//  tips
//
//  Created by Wadealanchan on 24/2/2024.
//

import Foundation
import Combine

final class CalculationViewModel: ObservableObject {
    @Published var billAmountText: String = "" 
    @Published var billAmount: Double?
    @Published var tipPercentage = 0.0
    @Published var tipsPercentage: [Double] = [8.0, 10.0, 15.0, 18.0]
    
    var tipAmount: Double {
        if let billAmount = billAmount {
            return billAmount / 100 * tipPercentage
        }
        return 0
    }
    
    var totalAmountWithTip: Double {
        if let billAmount = billAmount {
            let tipValue = billAmount / 100 * tipPercentage
            return billAmount + tipValue
        }
        return 0
    }
    
    lazy var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = defaultCurrency
        return formatter
    }()
    
    
    func selectTipPercentage(percentage: Double) {
        tipPercentage = percentage
    }
    
    func reset() {
        billAmount = nil
        tipPercentage = 0.0
    }
    
    func formatBillAmount() {
        if let amount = Double(billAmountText) {
            billAmountText = "\(defaultCurrency) \(amount)"
        }
    }
}


