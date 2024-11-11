//
//  FloatingButton.swift
//  TipGenius
//
//  Created by Wadealanchan on 4/11/2024.
//

import SwiftUI

struct FloatingButton: View {
    
    let action: (() -> Void)
    
    var body: some View {
        Button {
            
        } label: {
            Image(systemName: "plus")
                .font(.title.weight(.semibold))
                .padding()
                .background(Color.secondaryBlue)
                .clipShape(.circle)
                .shadow(radius: 4, x: 0, y: 4)
        }.padding()
    }
}

#Preview {
    FloatingButton(action: {})
}
