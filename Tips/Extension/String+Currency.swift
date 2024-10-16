//
//  Currency.swift
//  tips
//
//  Created by Wadealanchan on 24/2/2024.
//

import Foundation

let defaultCurrency = Locale.current.currency?.identifier ?? "CAD"

extension String {
      mutating func removedCurrencyPrefixString(_ currency: String = defaultCurrency) -> Double? {
          if self.hasPrefix(currency) {
              self = self.replacingOccurrences(of: "\(currency) ", with: "")
          }
          return Double(self)
      }
}
