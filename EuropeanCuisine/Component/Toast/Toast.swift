//
//  Toast.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 16/10/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct Toast: View {
    let kind: Kind
    let message: String

    enum Kind {
        case success
        case error
        case neutral

        var icon: Image {
            switch self {
            case .success:
                AppImage.Icon.toastSuccess.image
            case .error:
                AppImage.Icon.toastError.image
            case .neutral:
                AppImage.Icon.toastNeutral.image
            }
        }

        var background: Color {
            switch self {
            case .success:
                AppColor.success
            case .error:
                AppColor.destructive
            case .neutral:
                AppColor.accentContrast
            }
        }

        var foreground: Color {
            switch self {
            case .success, .error:
                .white
            case .neutral:
                AppColor.accentSecondary
            }
        }
    }

    var body: some View {
        HStack(spacing: Styles.spacing) {
            kind.icon
                .font(Styles.iconFont)

            Text(message)
                .font(Styles.messageFont)
                .multilineTextAlignment(.leading)
        }
        .foregroundStyle(kind.foreground)
        .padding(.horizontal, Styles.horizontalPadding)
        .padding(.vertical, Styles.verticalPadding)
        .background(kind.background, in: Styles.shape)
    }
}

extension Toast {
    static func success(_ message: LocalizedStringResource) -> Toast {
        Toast(kind: .success,
              message: String(localized: message))
    }

    static func success(_ message: String) -> Toast {
        Toast(kind: .success,
              message: message)
    }

    static func error(_ message: LocalizedStringResource) -> Toast {
        Toast(kind: .error,
              message: String(localized: message))
    }

    static func error(_ message: String) -> Toast {
        Toast(kind: .error,
              message: message)
    }

    static func neutral(_ message: LocalizedStringResource) -> Toast {
        Toast(kind: .neutral,
              message: String(localized: message))
    }

    static func neutral(_ message: String) -> Toast {
        Toast(kind: .neutral,
              message: message)
    }
}

fileprivate enum Styles {
    static let cornerRadius = AppToken.Primitive.radius2xl
    static let shape = RoundedRectangle(cornerRadius: cornerRadius)

    static let spacing = AppToken.Primitive.spacing3
    static let horizontalPadding = AppToken.Primitive.padding5
    static let verticalPadding = AppToken.Primitive.padding3

    static let iconFont: Font = .system(size: 24,
                                        weight: .medium)
    static let messageFont: Font = .system(size: 17,
                                           weight: .semibold)
}

#Preview {
    VStack(spacing: 32) {
        Toast.success("Adipisci porro quia aliquid consequatur.")

        Toast.error("Nulla voluptatem perferendis nulla ut et sed non.")
    }
    .padding()
}
