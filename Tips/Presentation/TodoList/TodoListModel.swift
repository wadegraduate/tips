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
//        TaskItem(title: "Flutter to-do list", isCompleted: false, isStarred: false),
//        TaskItem(title: "Task List View", isCompleted: false, isStarred: false),
//        TaskItem(title: "Task List View", isCompleted: false, isStarred: false),
//        TaskItem(title: "Task List View", isCompleted: false, isStarred: false),
//        TaskItem(title: "Task List View", isCompleted: false, isStarred: false),
    ]
    
    let useCase: TodoListUseCase
    
    init(useCase: TodoListUseCase = TodoListUseCaseImpl()){
        self.useCase = useCase
    }
    
    func addTask(taskText: String) {
        guard !taskText.isEmpty else { return }
        let newTask = TaskItem(title: taskText, isCompleted: false, isStarred: false)
        tasks.append(newTask)
    }
    
    func deleteTask(at index: Int) {
        tasks.remove(at: index)
    }
    
    func editTask(at index: Int) {
        
    }
    
}
