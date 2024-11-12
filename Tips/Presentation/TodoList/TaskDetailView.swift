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
                .foregroundColor(.iconTint)
            Text(text)
                .foregroundColor(.standardText)
        }
        .frame(height: 40)
        .listRowBackground(color)
    }
}

struct TaskDetailView: View {
    
    @Binding var task: TaskItem
    var onEditAction: (() -> Void)?
    
    @State private var oldTitle: String = ""
    @State private var oldDate = Date()
    @State private var oldNote : String = ""
    
    var body: some View {
        VStack {
            titleRow
            List {
                Section {
                    TaskDetailRowView(text: LocalizedString( "Add File"), systemImage: "paperclip")
                    HStack(spacing: 15) {
                        Image(systemName: "calendar")
                            .foregroundColor(.iconTint)
                        DatePicker("Created on",
                                   selection: $task.dueDate,
                                   displayedComponents: [.date]
                        )
                        .listRowBackground(Color.theme.secondaryBackground)
                        .frame(height: 40)
                        .onChange(of: task.dueDate) { newDate in
                            if oldDate != newDate {
                                oldDate = newDate
                                onEditAction?()
                            }
                        }
                    }
                }
                
                Section {
                    note
                } header: {
                    Text(LocalizedString( "Note"))
                }
                
            }
            .listStyle(.insetGrouped)
        }
        .background(Color.theme.background)
        .scrollContentBackground(.hidden)
        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarItems(trailing: Button(action: { onEditAction?() }) {
//            Text("Save")
//        }
//        .padding(.trailing, 5))
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
                .onChange(of: task.title) { newTitle in
                    if oldTitle != newTitle {
                        oldTitle = newTitle
                        onEditAction?()
                    }
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
        TextEditor(text: $task.note)
            .frame(height: 200)
            .foregroundColor(Color.standardText)
            .autocapitalization(.words)
            .scrollContentBackground(.hidden)
            .background(.clear)
            .listRowBackground(Color.theme.secondaryBackground)
            .onChange(of: task.note ) { newNote in
                if oldNote != newNote {
                    oldNote = newNote
                    onEditAction?()
                }
            }
    }
}

#Preview {
    NavigationView {
        TaskDetailView(task: .constant(.sampleData)
                       , onEditAction: nil)
    }
}
