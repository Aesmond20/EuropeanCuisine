//
//  SearchBar.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 25/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @Binding private var text: String
    private var onChangeFocused: ((Bool) -> Void)?

    init(text: Binding<String>) {
        self._text = text
        self.onChangeFocused = nil
    }

    init(text: Binding<String>, onChangeFocused: @escaping (Bool) -> Void) {
        self._text = text
        self.onChangeFocused = onChangeFocused
    }

    @FocusState private var isFocused
    @State private var showCloseButton: Bool = false

    var body: some View {
        HStack(alignment: .center,
               spacing: Styles.wrapperHorizontalSpacing) {
            searchBarView

            if showCloseButton {
                CloseSearchButton {
                    text = ""
                    isFocused = false
                }
                .transition(.move(edge: .trailing).combined(with: .blurReplace))
            }
        }
        .onChange(of: isFocused) { _, newValue in
            withAnimation(.smooth) {
                showCloseButton = newValue
                onChangeFocused?(newValue)
            }
        }
    }

    private var searchBarView: some View {
        HStack(alignment: .center,
               spacing: .zero) {
            AppImage.Icon.search.image
                .font(Styles.iconFont)
                .foregroundStyle(iconColor)
                .padding(.trailing, Styles.horizontalSpacing)

            TextField("",
                      text: $text,
                      prompt: Text("Placeholder").foregroundStyle(placeholderColor)
                          .font(Styles.placeholderFont))
                .focused($isFocused)
                .font(Styles.textFont)
                .foregroundStyle(textColor)

            if text.isNotEmpty {
                clearButton
            }
        }
        .padding(.horizontal, Styles.horizontalPadding)
        .frame(height: Styles.height)
        .background {
            Styles.shape
                .fill(backgroundColor)
        }
        .overlay {
            Styles.shape
                .strokeBorder(borderColor,
                              lineWidth: Styles.borderWidth)
        }
    }

    private var clearButton: some View {
        Button {
            text = ""
        } label: {
            AppImage.Icon.clearSearch.image
                .font(Styles.clearButtonFont)
                .foregroundStyle(Styles.clearButtonColor)
        }
        .padding(.leading, Styles.clearButtonLeadingSpacing)
    }

    private var placeholderColor: Color {
        if isFocused {
            Styles.placeholderFocusedColor
        } else {
            Styles.placeholderColor
        }
    }

    private var iconColor: Color {
        if isFocused {
            Styles.iconFocusedColor
        } else {
            Styles.iconColor
        }
    }

    private var textColor: Color {
        Styles.textColor
    }

    private var borderColor: Color {
        if isFocused {
            Styles.borderFocusedColor
        } else {
            Styles.borderColor
        }
    }

    private var backgroundColor: Color {
        if isFocused {
            Styles.backgroundFocused
        } else {
            Styles.background
        }
    }
}

fileprivate struct CloseSearchButton: View {
    let action: () -> Void

    var body: some View {
        Button("", action: action)
            .buttonStyle(.orangeadeIconProminent(kind: .primary,
                                                 icon: AppImage.Icon.closeSearch.image))
    }
}

fileprivate enum Styles {
    static let wrapperHorizontalSpacing = AppToken.Primitive.spacing3

    static let background = AppColor.searchbarBackground
    static let backgroundFocused: Color = .white

    static let height = AppToken.searchBarHeight
    static let horizontalPadding = AppToken.Primitive.padding4
    static let horizontalSpacing = AppToken.Primitive.spacing3
    static let cornerRadius = AppToken.searchBarCornerRadius
    static let shape = RoundedRectangle(cornerRadius: cornerRadius)

    static let borderColor = AppColor.searchbarBorder
    static let borderFocusedColor = AppColor.accentPrimary
    static let borderWidth: Double = 2

    static let iconColor = AppColor.Label.primary
    static let iconFocusedColor = AppColor.accentPrimary
    static let iconFont: Font = .system(size: 19,
                                        weight: .medium)

    static let placeholderColor = AppColor.Label.primary
    static let placeholderFocusedColor = AppColor.Label.secondary
    static let placeholderFont: Font = .system(size: 17,
                                               weight: .medium)

    static let textColor = AppColor.Label.title
    static let textFont: Font = .system(size: 17,
                                        weight: .medium)

    static let clearButtonLeadingSpacing = AppToken.Primitive.spacing1
    static let clearButtonColor = AppColor.Label.secondary
    static let clearButtonFont: Font = .system(size: 15,
                                               weight: .medium)
}

#Preview {
    @Previewable @State var text = ""
    @Previewable @State var text2 = ""

    VStack {
        SearchBar(text: $text)

        SearchBar(text: $text2, onChangeFocused: { print("Close \($0)") })
    }
    .padding()
}
