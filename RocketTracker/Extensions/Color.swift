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
    
    let accent = Color("Accent")
    let primaryBackground = Color("PrimaryBackground")
    let secondaryBackground = Color("SecondaryBackground")
    let tertiaryBackground = Color("TertiaryBackground")
    let primaryText = Color("PrimaryText")
    let secondaryText = Color("SecondaryText")
    let tertiaryText = Color("TertiaryText")
}

struct LaunchTheme {
    
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}
