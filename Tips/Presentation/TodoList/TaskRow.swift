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
                Label(LocalizedString("Delete"), systemImage: "trash")
            }
            .tint(.red)
        }
        .confirmationDialog("\(task.title) will be permanently deleted?", isPresented: $showConfirm, titleVisibility: .visible) {
            Button(LocalizedString("Confirm"), role: .destructive, action: deleteAction)
            Button(LocalizedString("Cancel"), role: .cancel) {}
        }
    }
}


#Preview {
    TaskRow(task: .constant(.sampleData), showConfirm: .constant(false), deleteAction: {})
}
