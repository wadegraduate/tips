//
//  CalculationView.swift
//  tips
//
//  Created by Wadealanchan on 24/2/2024.
//

import SwiftUI
import Combine

struct CalculationView: View {
    
    @StateObject var viewModel = CalculationViewModel()
    @FocusState var isFocused
    let currencyFormatter: NumberFormatter
    
    init() {
        // Initialize the currency formatter
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD" // Set this to your desired currency code
        self.currencyFormatter = formatter
    }
    
    var body: some View {
        NavigationStack {
            Form {
                billTotals
                billinformation
                tipAmount
                reset
            }
            .scrollContentBackground(.hidden)
            .background(Color.theme.background)
            .onTapGesture {
                hideKeyboard()
            }
            .navigationTitle(String(localized: "Tips"))
        }
    }
    
    
    var billinformation: some View {
        Section {
            CurrencyTextField(String(localized: "Enter Bill Amount"),
                              value: $viewModel.billAmount,
                              currencySymbol: defaultCurrency, 
                              font: .systemFont(ofSize: 30, weight: .medium),
                              foregroundColor: UIColor(.standardText),
                              textAlignment: .left,
                              clearsOnBeginEditing: true)
            .padding()
            .font(.system(size: 30, weight: .medium))
            .frame(height: 60)
            .keyboardType(.decimalPad)
            .listRowBackground(Color.theme.secondaryBackground)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
            
        } header: {
            Text(String(localized: "Bill Information"))
        }
    }
    
    var billTotals: some View {
        Section {
            LabeledAmountView(localisedString: "Subtotal", value: viewModel.billAmount ?? 0)
            LabeledAmountView(localisedString: "Tip", value: viewModel.tipAmount)
            LabeledAmountView(localisedString: "Total With Tip", value: viewModel.totalAmountWithTip)
        } header: {
            Text(String(localized: "Bill Totals"))
                .font(.system(size: 20, weight: .medium))
        }
        
    }
    
    var tipAmount: some View {
        Section {
            HStack {
                Slider(value: $viewModel.tipPercentage, in: 0...30, step: 1)
                    .accessibilityLabel(String(localized: "Tip Percentage Selection"))
                    .accessibilityHint(String(localized: "Selects the Tip Percentage"))
                Text("\(viewModel.tipPercentage, specifier: "%.0f")%")
                    .frame(width: 40, alignment: .trailing)
            }
            .listRowBackground(Color.theme.secondaryBackground)
            .frame(height: 50)
            
            tipAmountSelection
        } header: {
            Text(String(localized: "Tip Amount"))
                .font(.system(size: 20, weight: .medium))
        }
    }
    
    var tipAmountSelection: some View {
        ScrollView(.horizontal) {
            HStack {
                Spacer()
                ForEach(viewModel.tipPercentages, id: \.self) { percentage in
                    Button(action: {
                        viewModel.selectTipPercentage(percentage: percentage)
                    }, label: {
                        Text(percentage.toStringWithPercentageSymbol)
                            .frame(width: 35)
                    })
                    .foregroundColor(Color.theme.standardText)
                    .padding()
                    .background(Color.theme.secondaryBlue)
                    .cornerRadius(10)
                }
                Spacer()
            }
        }
        .listRowBackground(Color.theme.secondaryBackground)
    }
    
    var reset: some View {
        Section {
            HStack {
                Button(action: {
                    viewModel.resetValues()
                }, label: {
                    Spacer()
                    Text(String(localized: "Reset"))
                        .foregroundColor(Color.theme.red)
                    Spacer()
                })
                .foregroundColor(.white)
                .buttonStyle(.plain)
            }
            .contentShape(Rectangle())
            .listRowBackground(Color.theme.secondaryBackground)
            .onTapGesture {
                viewModel.resetValues()
            }
        }
    }
}


//#Preview {
//    CalculationView()
//}
