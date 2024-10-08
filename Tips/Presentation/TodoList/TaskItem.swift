//
//  TaskItem.swift
//  TipGenius
//
//  Created by Wadealanchan on 29/3/2024.
//

import Foundation
import RealmSwift

//class TaskItem: Object, Identifiable {
//    @Persisted(primaryKey: true) var id: ObjectId
//    @Persisted var title: String
//    @Persisted var isCompleted: Bool
//    @Persisted var isStarred: Bool
//    @Persisted var dueDate: Date
//    @Persisted var note: String?
//}


struct TaskItem {
    var title: String
    var isCompleted: Bool
    var isStarred: Bool
    //var dueDate: Date?
    var note: String?
}
