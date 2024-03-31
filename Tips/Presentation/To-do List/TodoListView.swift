//
//  TodoListView.swift
//  TipGenius
//
//  Created by Wadealanchan on 29/3/2024.
//

import SwiftUI

struct TodoListView: View {
    
    @EnvironmentObject var model: TodoListModel
    
    @State private var isShowingModal = false
    @State private var textFieldText = ""
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach($model.tasks) { $task in
                    TaskRow(task: $task)
                }
                .onDelete(perform: model.deleteTask)
            }
            .listRowSpacing(5)
            .background(Color.theme.background)
            .scrollContentBackground(.hidden)
            .navigationBarTitle(String(localized: "To-do"))
            .navigationBarItems(trailing: Button(action: {
                isShowingModal = true
            }) {
                Image(systemName: "plus")
            })
        }
        .overlay(
            isShowingModal ? TextFieldSheetView(text: $textFieldText,
                                                isShowingModal: $isShowingModal,
                                                addTask: { taskText in
                                                    withAnimation() {
                                                        model.addTask(taskText: taskText)
                                                    }
                                                }) : nil
        )
    }
}

#Preview {
    TodoListView()
        .environmentObject(TodoListModel())
}
