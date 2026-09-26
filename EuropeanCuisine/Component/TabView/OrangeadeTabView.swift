//
//  OrangeadeTabView.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 25/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct OrangeadeTab: View {
    let icon: Image
    let name: String
    let content: AnyView

    init(icon: Image,
         name: String,
         @ViewBuilder content: () -> some View) {
        self.icon = icon
        self.name = name
        self.content = AnyView(content())
    }

    var body: some View {
        content
    }
}

struct OrangeadeTabView: View {
    let content: [OrangeadeTab]

    @State private var selection: Int
    @State private var visibility: OrangeadeTabViewVisibility = .visible
    @Namespace private var namespace

    init(selection: Int = 0,
         @ViewBuilder content: () -> TupleView<some Any>) {
        self.content = content().getViews()
        self._selection = State(initialValue: selection)
    }

    private var tabBarHeight: Double {
        visibility == .visible ? 80 : 0
    }

    var body: some View {
        TabView(selection: $selection) {
            ForEach(content.indices, id: \.self) { index in
                NavigationStack {
                    content[index]
                        .frame(maxHeight: .infinity)
                        .background(Styles.sceneBackground.ignoresSafeArea(.all))
                        .safeAreaInset(edge: .bottom) {
                            Color.clear.frame(height: tabBarHeight)
                        }
                }
            }
            .toolbar(.hidden, for: .tabBar)
        }
        .background(Styles.background)
        .onPreferenceChange(OrangeadeTabViewVisibilityPreferenceKey.self) { vis in
            withAnimation(.smooth) {
                visibility = vis
            }
        }
        .safeAreaInset(edge: .bottom) {
            tabBarContent
                .offset(y: visibility == .visible ? 0 : tabBarHeight + 80)
                .opacity(visibility == .visible ? 1 : 0)
                .scaleEffect(visibility == .visible ? 1 : 0.8)
                .allowsHitTesting(visibility == .visible)
        }
    }

    private var tabBarContent: some View {
        HStack(alignment: .top, spacing: Styles.horizontalSpacing) {
            ForEach(content.indices, id: \.self) { index in
                TabBarItem(icon: content[index].icon,
                           name: content[index].name,
                           isOn: selection == index,
                           namespace: namespace)
                    .onTapGesture {
                        selection = index
                    }
            }
        }
        .padding(Styles.padding)
        .background {
            Styles.shape
                .fill(Styles.background)
        }
        .overlay {
            Styles.shape
                .strokeBorder(Styles.border,
                              lineWidth: Styles.borderWidth)
        }
        .animation(Styles.animation,
                   value: selection)
    }
}

extension TupleView {
    func getViews() -> [OrangeadeTab] {
        makeArray(from: value)
    }

    private func makeArray(from tuple: some Any) -> [OrangeadeTab] {
        func convert(child: Mirror.Child) -> OrangeadeTab? {
            child.value as? OrangeadeTab
        }

        return Mirror(reflecting: tuple)
            .children
            .compactMap(convert)
    }
}

enum OrangeadeTabViewVisibility {
    case visible
    case hidden
}

struct OrangeadeTabViewVisibilityPreferenceKey: PreferenceKey {
    static var defaultValue: OrangeadeTabViewVisibility = .visible

    static func reduce(value: inout OrangeadeTabViewVisibility,
                       nextValue: () -> OrangeadeTabViewVisibility) {
        if nextValue() == .hidden {
            value = .hidden
        }
    }
}

struct OrangeadeTabViewVisibilityViewModifier: ViewModifier {
    let visibility: OrangeadeTabViewVisibility

    func body(content: Content) -> some View {
        content
            .preference(key: OrangeadeTabViewVisibilityPreferenceKey.self,
                        value: visibility)
    }
}

extension View {
    func orangeadeTabViewVisibility(_ visibility: OrangeadeTabViewVisibility) -> some View {
        modifier(OrangeadeTabViewVisibilityViewModifier(visibility: visibility))
    }
}

private struct TabBarItem: View {
    let icon: Image
    let name: String
    let isOn: Bool
    let namespace: Namespace.ID

    var body: some View {
        VStack(spacing: Styles.itemVerticalSpacing) {
            icon
                .font(Styles.iconFont)
                .frame(width: Styles.iconWrapperSize,
                       height: Styles.iconWrapperSize)

            Text(name)
                .font(Styles.labelFont)
        }
        .foregroundStyle(isOn
            ? Styles.foregroundIsOn
            : Styles.foregroundIsOff)
        .padding(.vertical, Styles.itemVerticalPadding)
        .padding(.horizontal, Styles.itemHorizontalPadding)
        .background {
            if isOn {
                Styles.itemShape
                    .fill(Styles.itemBackgroundIsOn)
                    .matchedGeometryEffect(id: Styles.itemGeometryEffectID,
                                           in: namespace)
            }
        }
        .contentShape(Styles.itemShape)
    }
}

fileprivate enum Styles {
    static let sceneBackground = AppColor.Scene.background

    static let itemGeometryEffectID = "orangeade_tab_bar_item"
    static let animation = Animation.bouncy(extraBounce: 0.04)

    static let foregroundIsOff = AppColor.Label.title.opacity(0.72)
    static let foregroundIsOn = AppColor.Label.title

    static let shape = RoundedRectangle(cornerRadius: AppToken.Primitive.radius4xl)
    static let horizontalSpacing = AppToken.Primitive.spacing05
    static let padding = AppToken.Primitive.padding1
    static let background = AppColor.tabBarBackground
    static let border = AppColor.tabBarBorder
    static let borderWidth: Double = 1

    static let itemShape = RoundedRectangle(cornerRadius: AppToken.Primitive.radius3xl)
    static let itemVerticalSpacing = AppToken.Primitive.spacing05
    static let itemHorizontalPadding = AppToken.Primitive.padding4
    static let itemVerticalPadding = AppToken.Primitive.padding2
    static let itemBackgroundIsOn = AppColor.tabBarItemBackground

    static let iconFont: Font = .system(size: 18,
                                        weight: .semibold)
    static let iconWrapperSize: Double = 28

    static let labelFont: Font = .system(size: 10,
                                         weight: .semibold)
}

#Preview {
    OrangeadeTabView {
        OrangeadeTab(icon: AppTab.booths.icon,
                     name: AppTab.booths.name) {
            AppTab.booths.rootView
        }

        OrangeadeTab(icon: AppTab.workshops.icon,
                     name: AppTab.workshops.name) {
            AppTab.workshops.rootView
        }

        OrangeadeTab(icon: AppTab.reservations.icon,
                     name: AppTab.reservations.name) {
            AppTab.reservations.rootView
        }

        OrangeadeTab(icon: AppTab.profile.icon,
                     name: AppTab.profile.name) {
            AppTab.profile.rootView
        }
    }
}
