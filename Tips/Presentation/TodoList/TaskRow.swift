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
    let onDelete: () -> Void
    
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
                onDelete()
            } label: {
                Label(LocalizedString("Delete"), systemImage: "trash")
            }
            .tint(.red)
        }
    }
}


#Preview {
    TaskRow(task: .constant(.sampleData), onDelete: {})
}
