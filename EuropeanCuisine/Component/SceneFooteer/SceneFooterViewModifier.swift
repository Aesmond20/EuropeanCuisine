//
//  SceneFooterViewModifier.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 29/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct SceneFooterViewModifier: ViewModifier {
    let footerContent: AnyView

    init(content: () -> some View) {
        self.footerContent = AnyView(content())
    }

    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: .zero) {
                    footerContent
                        .padding(.top, Styles.topPadding)
                        .background {
                            Rectangle()
                                .fill(LinearGradient(colors: [
                                        Styles.background.opacity(0.64),
                                        Styles.background.opacity(1),
                                        Styles.background.opacity(1),
                                        Styles.background.opacity(1),
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom))
                                .padding(-20)
                                .blur(radius: 10)
                                .padding(20)
                                .padding(.bottom, -20)
                        }

                    Rectangle()
                        .fill(.clear)
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .background {
                            Rectangle()
                                .fill(Styles.background)
                                .ignoresSafeArea(.all,
                                                 edges: .bottom)
                        }
                }
            }
    }
}

extension View {
    func sceneFooter(content: () -> some View) -> some View {
        modifier(SceneFooterViewModifier(content: content))
    }
}

fileprivate enum Styles {
    static let background = AppColor.Scene.background

    static let topPadding = AppToken.Primitive.padding2
}
