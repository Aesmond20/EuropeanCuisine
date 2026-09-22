//
//  OrangeadeProminentButtonStyle.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 22/09/2026.
//

import SwiftUI

struct OrangeadeProminentButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.black)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(
                        Color.blue,
                        lineWidth: 2
                    )
            }
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        configuration.isPressed
                        ? .yellow
                        : .green
                    )
            }
            .scaleEffect(
                configuration.isPressed
                ? 1.1
                : 1
            )
            .offset(
                x:configuration.isPressed
                ? -100
                : 100
            )
            .animation(
                .bouncy(extraBounce: 0.2),
                value: configuration.isPressed
            )
    }
}

#Preview {
    Button("test button") {
        
    }
    .buttonStyle(OrangeadeProminentButtonStyle())
}
