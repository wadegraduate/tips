//
//  TodoListModel.swift
//  TipGenius
//
//  Created by Wadealanchan on 29/3/2024.
//

import Foundation
import Combine
import RealmSwift

class TodoListViewModel: ObservableObject {
    
    @Published var tasks: [TaskItem] = []
    let service: TodoListService
    private var taskCancellable: Task<Void, Never>?
    
    init(service: TodoListService = DefaultTodoListService()){
        self.service = service
        setupObserver()
    }
    
    private func setupObserver() {
        taskCancellable?.cancel()
        taskCancellable = Task { [weak self] in
            guard let self else { return }
            for await tasks in service.tasksStream {
                await MainActor.run {
                    self.tasks = tasks
                }
            }
        }
            
    }
    
    func addTask(taskText: String) {
        guard !taskText.isEmpty else { return }
        // Save to database
        let task = TaskItem(id: ObjectId.generate().stringValue,
                            title: taskText,
                            isCompleted: false,
                            isStarred: false,
                            dueDate: Date(),
                            note: "")
        service.addTask(task: task)
    }
    
    func deleteTask(at task: TaskItem) {
        service.deleteTask(task: task)
    }
    
    func editTask(at task: TaskItem) {
        service.editTask(task: task)
    }
}
