//
//  TextFieldSheetView.swift
//  TipGenius
//
//  Created by Wadealanchan on 29/3/2024.
//

import Foundation
import SwiftUI

typealias TaskTitle = String

struct TextFieldSheetView: View {
    enum Field {
        case textEditor
        case placeholder
    }
    
    @Binding var text: String
    @Binding var isShowingModal: Bool
    @FocusState private var focusedField: Field?
    
    var addTaskAction: (TaskTitle) -> Void
    var placeholderText: String = "Enter your text"
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                if text.isEmpty {
                    TextField(placeholderText, text: $text)
                        .frame(height: 150, alignment: .topLeading)
                        .focused($focusedField, equals: .placeholder)
                        .onAppear {
                            focusedField = .placeholder
                        }
                        .padding()
                } else {
                    TextEditor(text: $text)
                        .frame(height: 150)
                        .foregroundColor(Color.standardText)
                        .autocapitalization(.words)
                        .padding()
                        .scrollContentBackground(.hidden)
                        .background(.clear)
                        .focused($focusedField, equals: .textEditor)
                        .onAppear {
                            focusedField = .textEditor
                        }
                }
                            
                HStack(alignment: .center) {
                    Spacer()
                    Button(LocalizedString( "Cancel")) {
                        text = ""
                        isShowingModal = false
                    }
                    Spacer()
                    Button(LocalizedString( "Add")) {
                        addTaskAction(text)
                        text = ""
                        isShowingModal = false
                    }
                    Spacer()
                }
                .foregroundColor(Color.theme.standardText)
                .padding()
            }
            .background(Color.theme.sheetBackground)
            .cornerRadius(12)
            .shadow(radius: 10)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.1).edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    TextFieldSheetView(text: .constant(""), isShowingModal: .constant(false)) { _ in }
}


