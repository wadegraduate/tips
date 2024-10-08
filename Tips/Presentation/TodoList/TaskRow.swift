//
//  TaskRow.swift
//  TipGenius
//
//  Created by Wadealanchan on 29/3/2024.
//

import Foundation
import SwiftUI

struct TaskRow: View {
    @Binding var task: TaskItem
    @Binding var showConfirm: Bool
    let deleteAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                task.isCompleted.toggle()
            }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
            }
            .buttonStyle(BorderlessButtonStyle())
            
            Text(task.title)
            
            Spacer()
            
            Button(action: {
                task.isStarred.toggle()
            }) {
                Image(systemName: task.isStarred ? "star.fill" : "star")
                    .foregroundColor(task.isStarred ? .yellow : .gray)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .frame(minHeight: 40)
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button {
                showConfirm = true
            } label: {
                Label("Delete", systemImage: "trash")
            }
            .tint(.red)
        }
        .confirmationDialog("\(task.title) will be permanently deleted?", isPresented: $showConfirm, titleVisibility: .visible) {
            Button("Confirm", role: .destructive, action: deleteAction)
            Button("Cancel", role: .cancel) {}
        }
    }
}


#Preview {
    TaskRow(task: .constant(TaskItem(title: "Task", isCompleted: true, isStarred: true)), showConfirm: .constant(false), deleteAction: {})
}
