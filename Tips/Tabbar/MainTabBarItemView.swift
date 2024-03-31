//
//  MainTabBarItemView.swift
//  SwiftUICryptoProject
//
//  Created by Wadealanchan on 24/1/2024.
//

import SwiftUI

struct MainTabBarItemView: View {
    var tab: Tab
    var isSelected: Bool
    
    var body: some View {
        VStack(alignment: .center, content: {
            Image(isSelected ? tab.selectedImage : tab.defaultImage)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height:24)
            Text(tab.name)
                .font(.system(size: 12, weight: .medium))
//                .foregroundStyle(isSelected ? Color.theme.primaryGreen : Color.theme.neutralSolidWhite)
        })
    }
}

#Preview {
    MainTabBarItemView(tab: .toDoList, isSelected: true)
}
