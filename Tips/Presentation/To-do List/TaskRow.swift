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
        .listRowBackground(Color.theme.secondaryBackground)
        
    }
}


#Preview {
    TaskRow(task: .constant(TaskItem(title: "Task", isCompleted: true, isStarred: true)))
}
