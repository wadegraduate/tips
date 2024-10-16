//
//  Double+toString.swift
//  tips
//
//  Created by Wadealanchan on 24/2/2024.
//

import Foundation

extension Double {
    var toStringWithPercentageSymbol: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none // Use .none to avoid decimal places
        guard let formattedNumber = formatter.string(from: NSNumber(value: self)) else { return "\(self)%" }
        return "\(formattedNumber)%"
    }

}
