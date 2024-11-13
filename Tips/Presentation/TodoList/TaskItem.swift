//
//  TaskItem.swift
//  TipGenius
//
//  Created by Wadealanchan on 29/3/2024.
//

import Foundation
import RealmSwift

class TaskItemObject: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var isCompleted: Bool
    @Persisted var isStarred: Bool
    @Persisted var dueDate: Date
    @Persisted var note: String?
}


struct TaskItem: Identifiable, Codable, Equatable {
    var id: String
    var title: String
    var isCompleted: Bool
    var isStarred: Bool
    var dueDate: Date
    var note: String
    
}

extension TaskItem {
    
    init(taskObject: TaskItemObject) {
        self.id = taskObject.id.stringValue
        self.title = taskObject.title
        self.isCompleted = taskObject.isCompleted
        self.isStarred = taskObject.isStarred
        self.dueDate = taskObject.dueDate
        self.note = taskObject.note ?? ""
    }
    
    static let sampleData: TaskItem = .init(id: UUID().uuidString,
                                            title: "Task",
                                            isCompleted: true,
                                            isStarred: true,
                                            dueDate: Date(),
                                            note: "")
}

extension TaskItemObject {
    convenience init(taskItem: TaskItem) {
        self.init()
        do {
            self.id = try ObjectId(string: taskItem.id)
        } catch {
            self.id = .generate()
        }
        self.title = taskItem.title
        self.isCompleted = taskItem.isCompleted
        self.isStarred = taskItem.isStarred
        self.dueDate = taskItem.dueDate
        self.note = taskItem.note
    }
}
