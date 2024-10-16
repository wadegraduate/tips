//
//  TaskDetailView.swift
//  TipGenius
//
//  Created by Wadealanchan on 12/4/2024.
//

import SwiftUI

struct TaskDetailRowView: View {
    var text: String
    var systemImage: String
    var color: Color = Color.theme.secondaryBackground
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: systemImage)
                .foregroundColor(Color.iconTint)
            Text(text)
                .foregroundColor(Color.standardText)
        }
        .frame(height: 40)
        .listRowBackground(color)
    }
}

struct TaskDetailView: View {
    
    @State private var taskCreationDate = Date()
    @Binding var task: TaskItem
    
    var onEditAction: (() -> Void)?
    
    var body: some View {
        VStack {
            titleRow
            List {
                Section {
                    TaskDetailRowView(text: "Remind Me", systemImage: "bell")
                    TaskDetailRowView(text: "Add Due Date", systemImage: "calendar")
                    TaskDetailRowView(text: "Repeat", systemImage: "arrow.triangle.2.circlepath")
                    TaskDetailRowView(text: "Add File", systemImage: "paperclip")
                    DatePicker("Created on",
                               selection: $taskCreationDate,
                               displayedComponents: [.date]
                    )
                    .listRowBackground(Color.theme.secondaryBackground)
                    .frame(height: 40)
                }
                
                Section {
                    note
                } header: {
                    Text(String(localized: "Note"))
                }
                
            }
            .listStyle(.insetGrouped)
        }
        .background(Color.theme.background)
        .scrollContentBackground(.hidden)
        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarItems(trailing: Button(action: {
//           
//        }) {
//            Image(systemName: "square.and.arrow.down")
//        })
    }
    
    
    var titleRow: some View {
        HStack(spacing: 15) {
            Button(action: {
                task.isCompleted.toggle()
            }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
            }
            .buttonStyle(BorderlessButtonStyle())
            
            TextField("", text: $task.title)
                .font(.system(size: 25, weight: .medium))
                .onChange(of: task.title) { _ in
                    onEditAction?()
                }
        
            Spacer()
            Button(action: {
                task.isStarred.toggle()
            }, label: {
                Image(systemName: task.isStarred ? "star.fill" : "star")
                    .foregroundColor(task.isStarred ? .yellow : .gray)
            })
        }
        .padding([.top, .bottom, .leading, .trailing], 20)
        .background(Color.theme.secondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(height: 40)
        .padding([.top, .leading, .trailing, .trailing], 20)
    }
    
    var note: some View {
        TextEditor(text: $task.note.toUnwrapped(defaultValue: ""))
            .frame(height: 200)
            .foregroundColor(Color.standardText)
            .autocapitalization(.words)
            .scrollContentBackground(.hidden)
            .background(.clear)
            .listRowBackground(Color.theme.secondaryBackground)
    }
}

#Preview {
    NavigationView {
        TaskDetailView(task: .constant(TaskItem(title: "Test", isCompleted: false, isStarred: false))
                       , onEditAction: nil)
    }
}
