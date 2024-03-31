//
//  TodoListModel.swift
//  TipGenius
//
//  Created by Wadealanchan on 29/3/2024.
//

import Foundation
import Combine

class TodoListModel: ObservableObject {
    
    @Published var tasks: [TaskItem] = [
        TaskItem(title: "Flutter to-do list", isCompleted: false, isStarred: false),
        TaskItem(title: "Task List View", isCompleted: false, isStarred: false),
        TaskItem(title: "Task List View", isCompleted: false, isStarred: false),
        TaskItem(title: "Task List View", isCompleted: false, isStarred: false),
        TaskItem(title: "Task List View", isCompleted: false, isStarred: false),
    ]
    
    func addTask(taskText: String) {
        guard !taskText.isEmpty else { return }
        let newTask = TaskItem(title: taskText, isCompleted: false, isStarred: false)
        tasks.append(newTask)
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets) // Remove tasks at the specified indices
    }
    
}
