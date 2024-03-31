//
//  TaskItem.swift
//  TipGenius
//
//  Created by Wadealanchan on 29/3/2024.
//

import Foundation

struct TaskItem: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
    var isStarred: Bool
}
