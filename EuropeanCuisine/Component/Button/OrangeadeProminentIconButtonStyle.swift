//
//  OrangeadeProminentIconButtonStyle.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 25/09/2026.
//  Copyright © 2026 Aesmond. All rights reserved.
//

import SwiftUI

struct OrangeadeProminentIconButtonStyle: ButtonStyle {
    let kind: Kind
    let icon: Image

    @Environment(\.isEnabled) private var isEnabled

    enum Kind {
        case primary
        case secondary
        case tertiary
        case quaternary
        case back
        case onboarding
    }

    func makeBody(configuration: Configuration) -> some View {
        icon
            .font(Styles.iconFont)
            .foregroundStyle(foreground)
            .frame(width: Styles.size, height: Styles.size)
            .background {
                Styles.shape
                    .fill(background(role: configuration.role))
            }
            .overlay {
                if kind == .onboarding {
                    Styles.shape
                        .strokeBorder(Styles.onboardingBorder, lineWidth: Styles.onboardingBorderWidth)
                }
            }
            .scaleEffect(configuration.isPressed
                ? 1.2
                : 1)
            .opacity(configuration.isPressed
                ? 0.72
                : 1)
            .animation(Styles.pressedAnimation,
                       value: configuration.isPressed)
    }

    private var foreground: Color {
        if kind == .back {
            Styles.secondary
        } else if kind == .onboarding {
            Styles.secondary
        } else if isEnabled {
            Styles.foreground
        } else {
            Styles.disabledForeground
        }
    }

    private func background(role: ButtonRole?) -> Color {
        if !isEnabled {
            return Styles.disabledBackground
        } else if role == .destructive {
            return Styles.destructive
        }

        switch kind {
        case .primary:
            return Styles.primary
        case .secondary:
            return Styles.secondary
        case .tertiary:
            return Styles.tertiary
        case .quaternary:
            return Styles.quaternary
        case .back:
            return Styles.back
        case .onboarding:
            return Styles.onboarding
        }
    }
}

extension ButtonStyle where Self == OrangeadeProminentIconButtonStyle {
    static func orangeadeIconProminent(kind: Self.Kind,
                                       icon: Image) -> Self {
        Self(kind: kind,
             icon: icon)
    }
}

fileprivate enum Styles {
    static let size = AppToken.buttonHeight

    static let cornerRadius = AppToken.buttonCornerRadius
    static let shape = RoundedRectangle(cornerRadius: cornerRadius)

    static let foreground = AppColor.accentContrast

    static let primary = AppColor.accentPrimary
    static let secondary = AppColor.accentSecondary
    static let tertiary = AppColor.accentTertiary
    static let quaternary = AppColor.accentQuaternary
    static let destructive = AppColor.destructive
    static let back = AppColor.Page.background
    static let onboarding = AppColor.accentContrast

    static let disabledForeground = AppColor.disabledForeground
    static let disabledBackground = AppColor.disabledBackground

    static let onboardingBorder = AppColor.fieldBorder
    static let onboardingBorderWidth = AppToken.fieldBorderWidth

    static let iconFont: Font = .system(size: 24,
                                        weight: .semibold,
                                        design: .default)

    static let iconLabelSpacing: Double = AppToken.Primitive.spacing2

    static let pressedAnimation = AppToken.buttonPressedAnimation
}

#Preview {
    VStack(spacing: 24) {
        Button {} label: {
            Image(systemName: "star.fill")
        }
        .buttonStyle(.orangeadeIconProminent(kind: .primary, icon: Image(systemName: "star.fill")))

        Button {} label: {
            Image(systemName: "star.fill")
        }
        .buttonStyle(.orangeadeIconProminent(kind: .secondary, icon: Image(systemName: "star.fill")))

        Button {} label: {
            Image(systemName: "star.fill")
        }
        .buttonStyle(.orangeadeIconProminent(kind: .tertiary, icon: Image(systemName: "star.fill")))

        Button {} label: {
            Image(systemName: "star.fill")
        }
        .buttonStyle(.orangeadeIconProminent(kind: .quaternary, icon: Image(systemName: "star.fill")))

        Button {} label: {
            Image(systemName: "star.fill")
        }
        .buttonStyle(.orangeadeIconProminent(kind: .primary, icon: Image(systemName: "star.fill")))
        .disabled(true)

        Button(role: .destructive) {} label: {
            Image(systemName: "star.fill")
        }
        .buttonStyle(.orangeadeIconProminent(kind: .tertiary, icon: Image(systemName: "star.fill")))

        HStack {
            Button {} label: {
                Image(systemName: "arrow.left")
            }
            .buttonStyle(.orangeadeIconProminent(kind: .back, icon: Image(systemName: "arrow.left")))

            Button {} label: {
                Image(systemName: "arrow.left")
            }
            .buttonStyle(.orangeadeIconProminent(kind: .onboarding, icon: Image(systemName: "arrow.left")))
        }
    }
    .padding(32)
    .background(AppColor.Page.background)
//    .background(Color.black)
}
