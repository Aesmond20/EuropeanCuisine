//
//  OnboardingHeaderViewModifier.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 03/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct OnboardingHeaderViewModifier: ViewModifier {
    let headerContent: AnyView

    init(content: () -> some View) {
        self.headerContent = AnyView(content())
    }

    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .top) {
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

                    headerContent
                        .padding(.bottom, Styles.bottomPadding)
                        .background {
                            Rectangle()
                                .fill(LinearGradient(colors: [
                                        Styles.background.opacity(1),
                                        Styles.background.opacity(1),
                                        Styles.background.opacity(1),
                                        Styles.background.opacity(0.64),
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom))
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
    func onboardingHeader(content: () -> some View) -> some View {
        modifier(OnboardingHeaderViewModifier(content: content))
    }
}

fileprivate enum Styles {
    static let background = AppColor.Scene.background

    static let bottomPadding = AppToken.Primitive.padding2
}
