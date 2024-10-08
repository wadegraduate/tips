//
//  CustomButtonSnippet.swift
//  TipGenius
//
//  Created by Wadealanchan on 8/10/2024.
//

import Foundation
import SwiftUI

struct CustomButtonSnippet: View {
    var body: some View {
        Button("Label") {
            // Code
        }.buttonStyle(.style1)
    }
}

public struct CustomButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .fontWeight(.medium)
            .padding(.vertical, 12)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .background(.tint, in: .rect(cornerRadius: 20, style: .continuous))
            .opacity(configuration.isPressed ? 0.4 : 1.0)
    }
}

extension ButtonStyle where Self == CustomButtonStyle {
    static var style1: CustomButtonStyle { .init() }
}
