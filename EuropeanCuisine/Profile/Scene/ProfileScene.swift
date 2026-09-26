//
//  ProfileScene.swift
//  EuropeanCuisine
//
//  Created by Mathieu Nivelles on 26/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//

import SwiftUI

struct ProfileScene: View {
    var body: some View {
        ScrollView {}
            .scrollBounceBehavior(.basedOnSize)
            .background(Styles.background)
            .sceneHeader("Profile", onEdit: {})
    }
}

fileprivate enum Styles {
    static let background = AppColor.Scene.background
}

#Preview {
    ProfileScene()
}
