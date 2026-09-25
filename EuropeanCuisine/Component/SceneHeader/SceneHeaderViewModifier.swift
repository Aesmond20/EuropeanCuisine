//
//  SceneHeaderViewModifier.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 25/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct SceneHeaderViewModifier: ViewModifier {
    private let title: String
    private let onEdit: (() -> Void)?

    init(title: String) {
        self.title = title
        self.onEdit = nil
    }

    init(title: String, onEdit: @escaping () -> Void) {
        self.title = title
        self.onEdit = onEdit
    }

    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .top, spacing: .zero) {
                VStack(spacing: .zero) {
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .background {
                            Rectangle()
                                .fill(Styles.background)
                                .ignoresSafeArea(.all,
                                                 edges: .top)
                        }
                    
                    Group {
                        if let onEdit {
                            SceneHeader(title: title, onEdit: onEdit)
                        } else {
                            SceneHeader(title: title)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, Styles.bottomPading)
                    .background {
                        Rectangle()
                            .fill(
                                LinearGradient(colors: [
                                    Styles.background.opacity(0.64),
                                    Styles.background.opacity(1),
                                    Styles.background.opacity(1)
                                ],
                                               startPoint: .bottom,
                                               endPoint: .top)
                            )
                            .padding(-20)
                            .blur(radius: 10)
                            .padding(20)
                            .padding(.top, -20)
                    }
                }
            }
    }
}

extension View {
    func sceneHeader(_ title: String) -> some View {
        modifier(SceneHeaderViewModifier(title: title))
    }

    func sceneHeader(_ title: String, onEdit: @escaping () -> Void) -> some View {
        modifier(SceneHeaderViewModifier(title: title, onEdit: onEdit))
    }
}

fileprivate enum Styles {
    static let background = AppColor.Scene.background

    static let bottomPading = AppToken.Primitive.spacing6
}

#Preview("Title Only") {
    ScrollView {
        VStack(spacing: 16) {
            ForEach(0 ..< 40, id: \.self) { index in
                Text("Item \(index + 1)")
            }
        }
    }
    .sceneHeader("Quibusdam Ut")
}

#Preview("Title with Edit") {
    ScrollView {
        VStack(spacing: 16) {
            ForEach(0 ..< 40, id: \.self) { index in
                Text("Item \(index + 1)")
            }
        }
    }
    .sceneHeader("Quibusdam Ut", onEdit: {})
}
