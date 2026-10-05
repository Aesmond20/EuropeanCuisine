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
    private var searchText: Binding<String>?
    private let searchPlaceholder: String
    private var trailingSlot: AnyView?
    private let topTrailingSplash: TopTrailingSplashData

    @State private var showTrailingSlot: Bool = true
    @State private var hideTitle: Bool = false

    struct TopTrailingSplashData {
        var version: TopTrailingSplash.Version = .one
        var kind: TopTrailingSplash.Kind = .primary
    }

    init(title: String,
         topTrailingSplash: TopTrailingSplashData) {
        self.title = title
        self.onEdit = nil
        self.searchText = nil
        self.searchPlaceholder = ""
        self.trailingSlot = nil
        self.topTrailingSplash = topTrailingSplash
    }

    init(title: String,
         topTrailingSplash: TopTrailingSplashData,
         onEdit: @escaping () -> Void) {
        self.title = title
        self.onEdit = onEdit
        self.searchText = nil
        self.searchPlaceholder = ""
        self.trailingSlot = nil
        self.topTrailingSplash = topTrailingSplash
    }

    init(title: String,
         searchText: Binding<String>,
         searchPlaceholder: String,
         topTrailingSplash: TopTrailingSplashData) {
        self.title = title
        self.onEdit = nil
        self.searchText = searchText
        self.searchPlaceholder = searchPlaceholder
        self.trailingSlot = nil
        self.topTrailingSplash = topTrailingSplash
    }

    init(title: String,
         searchText: Binding<String>,
         searchPlaceholder: String,
         topTrailingSplash: TopTrailingSplashData,
         trailingAccessory: () -> some View) {
        self.title = title
        self.onEdit = nil
        self.searchText = searchText
        self.searchPlaceholder = searchPlaceholder
        self.trailingSlot = AnyView(trailingAccessory())
        self.topTrailingSplash = topTrailingSplash
    }

    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .top, spacing: .zero) {
                VStack(spacing: .zero) {
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .overlay {
                            TopTrailingSplash(version: topTrailingSplash.version,
                                              kind: topTrailingSplash.kind)
                                .frame(maxWidth: .infinity, maxHeight: .infinity,
                                       alignment: .topTrailing)
                                .ignoresSafeArea(.all, edges: .top)
                        }
                        .background {
                            Rectangle()
                                .fill(Styles.background)
                                .ignoresSafeArea(.all,
                                                 edges: .top)
                        }

                    VStack(spacing: Styles.verticalSpacing) {
                        if let onEdit, !hideTitle {
                            SceneHeader(title: title, onEdit: onEdit)
                        } else if !hideTitle {
                            SceneHeader(title: title)
                        }

                        searchBarWithTrailingAccessory
                    }
                    .padding(.horizontal)
                    .padding(.bottom, Styles.bottomPading)
                }
                .background {
                    Rectangle()
                        .fill(LinearGradient(colors: [
                                Styles.background.opacity(0.64),
                                Styles.background.opacity(1),
                                Styles.background.opacity(1),
                            ],
                            startPoint: .bottom,
                            endPoint: .top))
                        .padding(-20)
                        .blur(radius: 10)
                        .padding(20)
                        .padding(.top, -20)
                }
            }
    }

    @ViewBuilder
    private var searchBarWithTrailingAccessory: some View {
        if let searchText,
           let trailingSlot {
            HStack(alignment: .center,
                   spacing: Styles.horizontalSpacing) {
                SearchBar(text: searchText,
                          placeholder: searchPlaceholder) {
                    showTrailingSlot = !$0
                    hideTitle = $0
                }

                if showTrailingSlot {
                    trailingSlot
                        .transition(.move(edge: .trailing)
                            .combined(with: .blurReplace))
                }
            }
        } else if let searchText {
            SearchBar(text: searchText,
                      placeholder: searchPlaceholder) {
                hideTitle = $0
            }
        }
    }
}

extension View {
    func sceneHeader(_ title: String,
                     topTrailingSplash: SceneHeaderViewModifier
                         .TopTrailingSplashData = .init()) -> some View {
        modifier(SceneHeaderViewModifier(title: title, topTrailingSplash: topTrailingSplash))
    }

    func sceneHeader(_ title: LocalizedStringResource,
                     topTrailingSplash: SceneHeaderViewModifier
                         .TopTrailingSplashData = .init()) -> some View {
        modifier(SceneHeaderViewModifier(title: String(localized: title),
                                         topTrailingSplash: topTrailingSplash))
    }

    func sceneHeader(_ title: String,
                     topTrailingSplash: SceneHeaderViewModifier.TopTrailingSplashData = .init(),
                     onEdit: @escaping () -> Void) -> some View {
        modifier(SceneHeaderViewModifier(title: title, topTrailingSplash: topTrailingSplash,
                                         onEdit: onEdit))
    }

    func sceneHeader(_ title: LocalizedStringResource,
                     topTrailingSplash: SceneHeaderViewModifier.TopTrailingSplashData = .init(),
                     onEdit: @escaping () -> Void) -> some View {
        modifier(SceneHeaderViewModifier(title: String(localized: title),
                                         topTrailingSplash: topTrailingSplash,
                                         onEdit: onEdit))
    }

    func sceneHeader(_ title: String,
                     searchText: Binding<String>,
                     searchPlaceholder: String,
                     topTrailingSplash: SceneHeaderViewModifier
                         .TopTrailingSplashData = .init()) -> some View {
        modifier(SceneHeaderViewModifier(title: title,
                                         searchText: searchText,
                                         searchPlaceholder: searchPlaceholder,
                                         topTrailingSplash: topTrailingSplash))
    }

    func sceneHeader(_ title: LocalizedStringResource,
                     searchText: Binding<String>,
                     searchPlaceholder: LocalizedStringResource,
                     topTrailingSplash: SceneHeaderViewModifier
                         .TopTrailingSplashData = .init()) -> some View {
        modifier(SceneHeaderViewModifier(title: String(localized: title),
                                         searchText: searchText,
                                         searchPlaceholder: String(localized: searchPlaceholder),
                                         topTrailingSplash: topTrailingSplash))
    }

    func sceneHeader(_ title: String,
                     searchText: Binding<String>,
                     searchPlaceholder: String,
                     topTrailingSplash: SceneHeaderViewModifier.TopTrailingSplashData = .init(),
                     trailingAccessory: () -> some View) -> some View {
        modifier(SceneHeaderViewModifier(title: title,
                                         searchText: searchText,
                                         searchPlaceholder: searchPlaceholder,
                                         topTrailingSplash: topTrailingSplash,
                                         trailingAccessory: trailingAccessory))
    }

    func sceneHeader(_ title: LocalizedStringResource,
                     searchText: Binding<String>,
                     searchPlaceholder: LocalizedStringResource,
                     topTrailingSplash: SceneHeaderViewModifier.TopTrailingSplashData = .init(),
                     trailingAccessory: () -> some View) -> some View {
        modifier(SceneHeaderViewModifier(title: String(localized: title),
                                         searchText: searchText,
                                         searchPlaceholder: String(localized: searchPlaceholder),
                                         topTrailingSplash: topTrailingSplash,
                                         trailingAccessory: trailingAccessory))
    }
}

fileprivate enum Styles {
    static let background = AppColor.Scene.background

    static let bottomPading = AppToken.Primitive.spacing6

    static let verticalSpacing = AppToken.Primitive.spacing2
    static let horizontalSpacing = AppToken.Primitive.spacing3
}

#Preview("Title Only") {
    ScrollView {
        VStack(spacing: 16) {
            ForEach(0 ..< 40, id: \.self) { index in
                Text("Item \(index + 1)")
            }
        }
    }
    .sceneHeader("Quibusdam Ut",
                 topTrailingSplash: .init(version: .two,
                                          kind: .quaternary))
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

#Preview("Title with Search") {
    @Previewable @State var searchText = ""

    ScrollView {
        VStack(spacing: 16) {
            ForEach(0 ..< 40, id: \.self) { index in
                Text("Item \(index + 1)")
            }
        }
    }
    .sceneHeader("Quibusdam Ut",
                 searchText: $searchText,
                 searchPlaceholder: "Search lorem")
}

#Preview("Title with Search And Button") {
    @Previewable @State var searchText = ""

    ScrollView {
        VStack(spacing: 16) {
            ForEach(0 ..< 40, id: \.self) { index in
                Text("Item \(index + 1)")
            }
        }
    }
    .sceneHeader("Quibusdam Ut",
                 searchText: $searchText,
                 searchPlaceholder: "Search ipsum") {
        Button("") {}
            .buttonStyle(.orangeadeIconProminent(kind: .quaternary,
                                                 icon: AppImage.Icon.book.image))
    }
}
