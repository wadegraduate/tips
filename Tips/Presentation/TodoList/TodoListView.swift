//
//  TodoListView.swift
//  TipGenius
//
//  Created by Wadealanchan on 29/3/2024.
//

import SwiftUI

struct TodoListView: View {
    
    @ObservedObject var model: TodoListModel
    
    @State private var isShowingModal = false
    @State private var textFieldText = ""
    @State private var showConfirm = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                Color.theme.background
                    .edgesIgnoringSafeArea(.all)
                Group {
                    if model.tasks.isEmpty {
                        GeometryReader { geometry in
                            Text("Add your new item")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.gray)
                                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        }
                    } else {
                        List {
                            ForEach(model.tasks.indices, id: \.self) { index in
                                ZStack {
                                    NavigationLink(destination: TaskDetailView(task: $model.tasks[index])) {
                                        EmptyView()
                                    }
                                    .opacity(0.0)
                                    .buttonStyle(.plain)
                                    TaskRow(task: $model.tasks[index], showConfirm: $showConfirm) {
                                        model.deleteTask(at: index)
                                    }
                                }
                            }
                            .listRowBackground(Color.theme.secondaryBackground)
                        }
                        .listRowSpacing(5)
                        .background(Color.theme.background)
                        .scrollContentBackground(.hidden)
                    }
                }
                Button {
                    isShowingModal = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color.white)
                        .clipShape(.circle)
                        .shadow(radius: 4, x: 0, y: 4)
                }.padding()
            }
            .navigationBarTitle(String(localized: "To-do"))
        }
        .navigationBarTitle(String(localized: "To-do"))
        .navigationViewStyle(.stack)
        .sheet(isPresented: $isShowingModal, content: {
            NewToDoTaskSheetView(text: $textFieldText,
                                 isShowingModal: $isShowingModal,
                                 addTaskAction: { taskText in
                withAnimation() {
                    model.addTask(taskText: taskText)
                }
            })
        })
//        .overlay(
//            isShowingModal ? TextFieldSheetView(text: $textFieldText,
//                                                isShowingModal: $isShowingModal,
//                                                addTaskAction: { taskText in
//                                                    withAnimation() {
//                                                        model.addTask(taskText: taskText)
//                                                    }
//                                                }) : nil
//        )
    }
}

#Preview {
    TodoListView(model: TodoListModel())
}
