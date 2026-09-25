//
//  OrangeadeProminentButtonStyle.swift
//  EuropeanCuisine
//
//  Created by Aesmond on 22/09/2026.
//

import SwiftUI

struct OrangeadeProminentButtonStyle: ButtonStyle {
    let kind: Kind
    let icon: Image?
    let isFullWidth: Bool

    @Environment(\.isEnabled) private var isEnabled

    enum Kind {
        case primary
        case secondary
        case tertiary
        case quaternary
    }

    func makeBody(configuration: Configuration) -> some View {
        Group {
            if let icon {
                HStack(alignment: .center,
                       spacing: Styles.iconLabelSpacing)
                {
                    icon
                        .font(Styles.iconFont)

                    configuration.label
                        .font(Styles.labelFont)
                }
            } else {
                configuration.label
                    .font(Styles.labelFont)
            }
        }
        .foregroundStyle(foreground)
        .padding(.horizontal, Styles.hPadding)
        .frame(height: Styles.height)
        .if(isFullWidth) { view in
            view
                .frame(maxWidth: .infinity,
                       alignment: .center)
        }
        .background {
            Styles.shape
                .fill(background(role: configuration.role))
        }
        .scaleEffect(configuration.isPressed
            ? animationScale
            : 1)
        .rotationEffect(.degrees(configuration.isPressed
                ? animationRotationDegrees
                : 0))
        .opacity(configuration.isPressed
            ? 0.72
            : 1)
        .animation(Styles.pressedAnimation,
                   value: configuration.isPressed)
    }

    private var animationRotationDegrees: Double {
        isFullWidth ? 2 : 4
    }

    private var animationScale: Double {
        isFullWidth ? 1.1 : 1.2
    }

    private var foreground: Color {
        if isEnabled {
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
        }
    }
}

extension ButtonStyle where Self == OrangeadeProminentButtonStyle {
    static func orangeadeProminent(kind: Self.Kind,
                                   icon: Image? = nil,
                                   isFullWidth: Bool = false) -> Self
    {
        Self(kind: kind,
             icon: icon,
             isFullWidth: isFullWidth)
    }
}

fileprivate enum Styles {
    static let hPadding = AppToken.Primitive.padding4
    static let height = AppToken.buttonHeight

    static let cornerRadius = AppToken.buttonCornerRadius
    static let shape = RoundedRectangle(cornerRadius: cornerRadius)

    static let foreground = AppColor.accentContrast

    static let primary = AppColor.accentPrimary
    static let secondary = AppColor.accentSecondary
    static let tertiary = AppColor.accentTertiary
    static let quaternary = AppColor.accentQuaternary
    static let destructive = AppColor.destructive

    static let disabledForeground = AppColor.disabledForeground
    static let disabledBackground = AppColor.disabledBackground

    static let labelFont: Font = .system(size: 20,
                                         weight: .semibold,
                                         design: .default)

    static let iconFont: Font = .system(size: 22,
                                        weight: .semibold,
                                        design: .default)

    static let iconLabelSpacing: Double = AppToken.Primitive.spacing2

    static let pressedAnimation = AppToken.buttonPressedAnimation
}

#Preview {
    VStack(spacing: 24) {
        HStack(spacing: 20) {
            Button("Te 1") {}
                .buttonStyle(.orangeadeProminent(kind: .primary))

            Button("Te 2") {}
                .buttonStyle(.orangeadeProminent(kind: .primary))
                .disabled(true)

            Button("Te 3") {}
                .buttonStyle(.orangeadeProminent(kind: .secondary))
        }

        Button("Vanille") {}
            .buttonStyle(.orangeadeProminent(kind: .primary))

        Button("Vanille", role: .destructive) {}
            .buttonStyle(.orangeadeProminent(kind: .primary,
                                             icon: Image(systemName: "trash")))

        Button("Vanille") {}
            .buttonStyle(.orangeadeProminent(kind: .secondary,
                                             isFullWidth: true))

        Button("Vanille") {}
            .buttonStyle(.orangeadeProminent(kind: .primary))
            .disabled(true)

        Button("Vanille") {}
            .buttonStyle(.orangeadeProminent(kind: .tertiary,
                                             icon: Image(systemName: "info"),
                                             isFullWidth: true))

        Button("Vanille") {}
            .buttonStyle(.orangeadeProminent(kind: .quaternary))

        Button("Vanille") {}
            .buttonStyle(.orangeadeProminent(kind: .primary))
            .disabled(true)
    }
    .padding(32)
    .background(AppColor.Page.background)
}
