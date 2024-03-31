//
//  Tab.swift
//  SwiftUICryptoProject
//
//  Created by Wadealanchan on 24/1/2024.
//

import Foundation

enum Tab: CaseIterable {
    case tipCalculator
    case toDoList
 
    
    var defaultImage: String {
        switch self {
        case .tipCalculator:
            return "img_tabbar_home"
        case .toDoList:
            return "img_tabbar_trade"
        }
    }
    
    var selectedImage: String {
        switch self {
        case .tipCalculator:
            return "img_tabbar_home_selected"
        case .toDoList:
            return "img_tabbar_trade_selected"
        }
    }
    
    var name: String {
        switch self {
        case .tipCalculator:
            return "Tip Calculator"
        case .toDoList:
            return "To-Do List"
        }
    }
}
