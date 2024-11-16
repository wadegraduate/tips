//
//  NewToDoTaskSheetView.swift
//  TipGenius
//
//  Created by Wadealanchan on 8/10/2024.
//

import SwiftUI

typealias TaskTitle = String

struct NewToDoTaskSheetView: View {
  
    @State private(set) var text: String? = nil
    @Binding var isShowingModal: Bool
        
    @State private var taskCreationDate = Date()
    
    var addTaskAction: (TaskTitle) -> Void
    var placeholderText: String = LocalizedString("Enter your text")
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                dateRow
                textEditor
                Spacer()
                Button(LocalizedString("Save")) {
                    addTaskAction(text ?? "")
                    text = ""
                    isShowingModal = false
                }
                .buttonStyle(.style1)
                .padding()
                
            }
            .background(.sheetColor1)
            .navigationBarTitle(LocalizedString("Add a new task"), displayMode: .inline)
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
    
    var dateRow: some View {
        VStack {
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
        }
    }
    
    var textEditor: some View {
        ZStack(alignment: .topLeading) {
            Text(placeholderText)
                .padding(EdgeInsets(top: 8, leading: 4, bottom: 0, trailing: 0))
                .foregroundColor(.gray)
                .opacity(text != nil ? 0 : 1)
            
            TextEditor(text: Binding($text, replacingNilWith: ""))
                .padding(.all, 0)
                .opacity(text != nil ? 1 : 0.8)
                .scrollContentBackground(.hidden)
        }
        .padding()
    }
}

#Preview {
    NewToDoTaskSheetView(isShowingModal: .constant(false)) { _ in }
}
