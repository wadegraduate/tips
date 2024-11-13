//
//  TodoListView.swift
//  TipGenius
//
//  Created by Wadealanchan on 29/3/2024.
//

import SwiftUI

struct TodoListView: View {
    
    @ObservedObject var viewModel: TodoListViewModel
    
    @State private var isShowingModal = false
    @State private var showConfirm = false
    
    private var emptyStateView: some View {
        GeometryReader { geometry in
            Text(LocalizedString("Add your new item"))
                .font(.headline)
                .foregroundColor(.gray)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
    }
    
    private var taskListView: some View {
        List {
            ForEach($viewModel.tasks) { $task in
                TaskRowContainer(task: $task,
                                 showConfirm: $showConfirm,
                                 onDelete: { viewModel.deleteTask(at: task) },
                                 onEdit: { viewModel.editTask(at: task) })
            }
            .listRowBackground(Color.theme.secondaryBackground)
        }
        .listRowSpacing(5)
        .background(Color.theme.background)
        .scrollContentBackground(.hidden)
        .animation(.easeInOut, value: viewModel.tasks)
    }
    
    private var addButton: some View {
        Button {
            isShowingModal = true
        } label: {
            Image(systemName: "plus")
                .tint(Color.theme.standardText)
                .font(.title.weight(.semibold))
                .padding()
                .background(Color.theme.secondaryBlue)
                .clipShape(.circle)
                .shadow(radius: 4, x: 0, y: 4)
        }
        .padding()
        .accessibilityLabel(LocalizedString("Add new task"))
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                Color.theme.background
                    .edgesIgnoringSafeArea(.all)
                
                if viewModel.tasks.isEmpty {
                    emptyStateView
                } else {
                    taskListView
                }
                addButton
            }
            .navigationBarTitle(LocalizedString("To-do"))
        }
        .navigationViewStyle(.stack)
        .sheet(isPresented: $isShowingModal, content: {
            NewToDoTaskSheetView(isShowingModal: $isShowingModal,
                                 addTaskAction: { taskText in
                withAnimation() {
                    viewModel.addTask(taskText: taskText)
                }
            })
        })
    }
}

private struct TaskRowContainer: View {
    @Binding var task: TaskItem
    @Binding var showConfirm: Bool
    let onDelete: () -> Void
    let onEdit: () -> Void
    
    var body: some View {
        ZStack {
            NavigationLink(destination: TaskDetailView(
                task: $task,
                onEdit: onEdit
            )) {
                EmptyView()
            }
            .opacity(0)
            .buttonStyle(.plain)
            
            TaskRow(
                task: $task,
                showConfirm: $showConfirm,
                onDelete: onDelete
            )
            .onChange(of: task.isStarred) { _ in
                onEdit()
            }
        }
    }
}

#Preview {
    TodoListView(viewModel: TodoListViewModel())
}
