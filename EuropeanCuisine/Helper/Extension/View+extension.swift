//
//  View+extension.swift
//  EuropeanCuisine
//  
//  Created by Mathieu Nivelles on 22/09/2026.
//  Copyright © 2026 Mathieu Nivelles. All rights reserved.
//  

import SwiftUI

extension View {
    
    @ViewBuilder
    func `if`<Content: View>(_ condition: @autoclosure () -> Bool,
                             transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}
