//
//  LaunchView.swift
//  Tips
//
//  Created by Wadealanchan on 23/2/2024.
//

import SwiftUI

struct LaunchView: View {
    @State private var loadingText: [String] = "Tipsss".map { String($0)}
    @State private var showLoadingText: Bool = false
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var isActive: Bool
    
    private let timer = Timer.publish(every: 0.1,
                              on: .main,
                              in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            Image("SplashScreenLogo")
                .resizable()
                .frame(width: 100, height: 100)
            
            ZStack {
                if showLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.theme.standardText)
                                .offset(y: counter == index ? -5 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 70)
        }
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                let lastIndex = loadingText.count - 1
                
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    
                    if loops >= 2 {
                        isActive = true
                    }
                } else {
                    counter += 1
                }
            }
        }
    }
}

#Preview {
    LaunchView(isActive: .constant(false))
}
