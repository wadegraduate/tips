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


struct Task: Identifiable, Codable {
    var id: String
    var title: String
    var isCompleted: Bool
    var isStarred: Bool
    var dueDate: Date
    var note: String?
    
}

extension Task {
    init(taskObject: TaskItemObject) {
        self.id = taskObject.id.stringValue
        self.title = taskObject.title
        self.isCompleted = taskObject.isCompleted
        self.isStarred = taskObject.isStarred
        self.dueDate = taskObject.dueDate
        self.note = taskObject.note
    }
    
    static let sampleData: Task = .init(id: UUID().uuidString, title: "Task", isCompleted: true, isStarred: true, dueDate: Calendar.current.date(from: DateComponents(year: 2024, month: 10, day: 31))!)
}
