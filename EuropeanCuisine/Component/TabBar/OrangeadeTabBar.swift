//
//  OrangeadeTabBar.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 25/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct OrangeadeTabBar: View {
    @State private var selection: TabItem = .booths

    @Namespace private var namespace

    var body: some View {
        HStack(alignment: .top, spacing: Styles.horizontalSpacing) {
            ForEach(TabItem.allCases) { tab in
                TabBarItem(tabItem: tab,
                           isOn: tab == selection,
                           namespace: namespace)
                    .onTapGesture {
                        selection = tab
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

private struct TabBarItem: View {
    let tabItem: TabItem
    let isOn: Bool
    let namespace: Namespace.ID

    var body: some View {
        VStack(spacing: Styles.itemVerticalSpacing) {
            tabItem.icon
                .font(Styles.iconFont)
                .frame(width: Styles.iconWrapperSize,
                       height: Styles.iconWrapperSize)

            Text(tabItem.name)
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
    }
}

fileprivate enum Styles {
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
    OrangeadeTabBar()
        .padding(24)
        .background(AppColor.Page.background)
}
