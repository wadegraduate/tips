//
//  View+Keyboard.swift
//  tips
//
//  Created by Wadealanchan on 24/2/2024.
//

import Foundation
import SwiftUI


extension View {
    /// Dismisses the keyboard if it is currently displaying.
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
