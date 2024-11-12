//
//  NewCurrencyTextField.swift
//  TipGenius
//
//  Created by Wadealanchan on 3/11/2024.
//

import SwiftUI

struct CurrencyTextField: View {
    
    @Binding var value: Double?
    @State private var amount: String = ""
    @FocusState private var isFocused: Bool
    
    var placeholder: String? = nil
    
        
    var body: some View {
        VStack {
            TextField(placeholder ?? LocalizedString( "Enter Amount"), text: $amount)
                .keyboardType(.decimalPad)
                .onChange(of: amount) { newValue in
                    if newValue.isEmpty {
                        value = 0.0
                    }
                    
                    let filtered = newValue.filter { "0123456789.".contains($0) }
                    
                    if filtered.filter({ $0 == "." }).count > 1 {
                        amount = String(amount.dropLast())
                        return
                    }
                    
                    if let doubleValue = Double(filtered) {
                        value = doubleValue
                    }
                    
                }
                .font(.system(size: 30, weight: .medium))
                .frame(height: 60)
                .focused($isFocused)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                           isFocused = false
                        }
                    }
                }
        }
    }
}

#Preview {
    CurrencyTextField(value: .constant(0.0))
}
