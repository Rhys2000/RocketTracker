//
//  Color.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/17/23.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let primaryBackground = Color("PrimaryBackgroundColor")
    let secondaryBackground = Color("SecondaryBackgroundColor")
    let primaryText = Color("PrimaryTextColor")
    let secondaryText = Color("SecondaryTextColor")
}

struct LaunchTheme {
    
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}
