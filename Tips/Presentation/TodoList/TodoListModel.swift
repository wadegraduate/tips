//
//  TodoListModel.swift
//  TipGenius
//
//  Created by Wadealanchan on 29/3/2024.
//

import Foundation
import Combine
import RealmSwift

class TodoListModel: ObservableObject {
    
    @ObservedResults(TaskItemObject.self) var storedTaskItems
    @Published var tasks: [TaskItem] = []
    private var token: NotificationToken?
    
    let useCase: TodoListUseCase
    
    init(useCase: TodoListUseCase = TodoListUseCaseImpl()){
        self.useCase = useCase
        setupObserver()
    }
    
    private func setupObserver() {
        do {
            let realm = try Realm()
            let results = realm.objects(TaskItemObject.self)
            
            token = results.observe({ [weak self] changes in
                self?.tasks = results.map(TaskItem.init)
            })
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func addTask(taskText: String) {
        guard !taskText.isEmpty else { return }
        let task = TaskItemObject()
        task.id = .generate()
        task.title = taskText
        task.isCompleted = false
        task.isStarred = false
        $storedTaskItems.append(task)
    }
    
    func deleteTask(at index: Int) {
        do {
            let realm = try Realm()
            let objectId = try ObjectId(string: tasks[index].id)
            if let object = realm.object(ofType: TaskItemObject.self, forPrimaryKey: objectId) {
                try realm.write {
                    realm.delete(object)
                }
            }
        } catch let error {
            print(error)
        }
    }
    
    func editTask(at index: Int) {
        do {
            let realm = try Realm()
            let objectId = try ObjectId(string: tasks[index].id)
            if let object = realm.object(ofType: TaskItemObject.self, forPrimaryKey: objectId) {
                try realm.write {
                    object.title = tasks[index].title
                    object.isCompleted = tasks[index].isCompleted
                    object.isStarred = tasks[index].isStarred
                }
            }
        } catch let error {
            print(error)
        }
    }
    
}
