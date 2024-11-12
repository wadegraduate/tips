//
//  TodoListView.swift
//  TipGenius
//
//  Created by Wadealanchan on 29/3/2024.
//

import SwiftUI

struct TodoListView: View {
    
    @ObservedObject var model: TodoListViewModel
    
    @State private var isShowingModal = false
    @State private var showConfirm = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                Color.theme.background
                    .edgesIgnoringSafeArea(.all)
                Group {
                    if model.tasks.isEmpty {
                        GeometryReader { geometry in
                            Text(LocalizedString("Add your new item"))
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.gray)
                                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        }
                    } else {
                        List($model.tasks) { $task in
                            ZStack {
                                // This is to hide arrow
                                NavigationLink(destination:  TaskDetailView(task: $task, onEditAction: {
                                    model.editTask(at: task)
                                })) {
                                    EmptyView()
                                }
                                .opacity(0.0)
                                .buttonStyle(.plain)
                                TaskRow(task: $task, showConfirm: $showConfirm) {
                                    model.deleteTask(at: task)
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
        }
        .navigationBarTitle(LocalizedString("To-do"))
        .navigationViewStyle(.stack)
        .sheet(isPresented: $isShowingModal, content: {
            NewToDoTaskSheetView(isShowingModal: $isShowingModal,
                                 addTaskAction: { taskText in
                withAnimation() {
                    model.addTask(taskText: taskText)
                }
            })
        })
    }
}

#Preview {
    TodoListView(model: TodoListViewModel())
}
