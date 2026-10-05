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
    let topTrailingSplash: TopTrailingSplashData

    struct TopTrailingSplashData {
        var version: TopTrailingSplash.Version = .one
        var kind: TopTrailingSplash.Kind = .primary
    }

    init(topTrailingSplash: TopTrailingSplashData,
         content: () -> some View) {
        self.headerContent = AnyView(content())
        self.topTrailingSplash = topTrailingSplash
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
                            TopTrailingSplash(version: topTrailingSplash.version,
                                              kind: topTrailingSplash.kind)
                                .ignoresSafeArea(.all, edges: .top)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
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
    func onboardingHeader(topTrailingSplash: OnboardingHeaderViewModifier
        .TopTrailingSplashData = .init(),
        // swiftlint:disable:next vertical_parameter_alignment
        content: () -> some View) -> some View {
        modifier(OnboardingHeaderViewModifier(topTrailingSplash: topTrailingSplash,
                                              content: content))
    }
}

fileprivate enum Styles {
    static let background = AppColor.Scene.background

    static let bottomPadding = AppToken.Primitive.padding2
}
