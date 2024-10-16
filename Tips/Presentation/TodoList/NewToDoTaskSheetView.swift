//
//  NewToDoTaskSheetView.swift
//  TipGenius
//
//  Created by Wadealanchan on 8/10/2024.
//

import SwiftUI

struct NewToDoTaskSheetView: View {
    enum Field {
        case textEditor
        case placeholder
    }
    
    
    @Binding var text: String
    @Binding var isShowingModal: Bool
    @FocusState private var focusedField: Field?
    @State private var taskCreationDate = Date()
    
    var addTaskAction: (TaskTitle) -> Void
    var placeholderText: String = "Enter your text"
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                Divider()
                HStack {
                    Image(systemName: "calendar.circle")
                        .resizable()
                        .foregroundStyle(Color.iconTint)
                        .frame(width: 35, height: 35)
                    DatePicker("", selection: $taskCreationDate)
                }
                .padding()
                Divider()
                
                if text.isEmpty {
                    TextField(placeholderText, text: $text)
                        //.frame(height: 150, alignment: .topLeading)
                        .focused($focusedField, equals: .placeholder)
                        .onAppear {
                            focusedField = .placeholder
                        }
                        .padding()
                } else {
                    TextEditor(text: $text)
                        //.frame(height: 150)
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
                Spacer()
                Button("Save") {
                    addTaskAction(text)
                    text = ""
                    isShowingModal = false
                }
                .buttonStyle(.style1)
                .padding()
                
                
                
            }
            .navigationBarTitle("Add a new task", displayMode: .inline)
            .navigationBarItems(leading: Button {
                text = ""
                isShowingModal = false
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.iconTint)
                }
                .foregroundStyle(.white)
            )
        }
        
        
    }
}

#Preview {
    NewToDoTaskSheetView(text: .constant(""), isShowingModal: .constant(false)) { _ in }
}
