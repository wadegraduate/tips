//
//  LabeledAmountView.swift
//  tips
//
//  Created by Wadealanchan on 24/2/2024.
//

import SwiftUI

struct LabeledAmountView: View {
    
    let localisedString: LocalizedStringKey
    var value: Double
    var currencyCode: String = defaultCurrency
    
    
    var body: some View {
        HStack {
            Text(localisedString)
                .foregroundColor(Color.theme.primaryGray)
                .font(.system(size: 20, weight: .medium))
            Spacer()
            Text(value, format: .currency(code: currencyCode))
                .font(.system(size: 20, weight: .medium))
        }
        .listRowBackground(Color.theme.secondaryBackground)
        .frame(height: 40)
    }
}

//#Preview {
//    LabeledAmountView(localisedString: "", value: 0.0, currencyCode: "")
//}
