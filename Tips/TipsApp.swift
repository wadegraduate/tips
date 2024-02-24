//
//  TipsApp.swift
//  Tips
//
//  Created by Wadealanchan on 21/2/2024.
//

import SwiftUI

@main
struct TipsApp: App {
    
    @State private var isActive = false
    
    var body: some Scene {
        WindowGroup {
            if isActive {
                CalculationView()
            }else {
                LaunchView(isActive: $isActive)
            }
        }
    }
}
