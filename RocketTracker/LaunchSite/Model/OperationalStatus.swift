//
//  OperationalStatus.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/8/23.
//

import Foundation
import SwiftUI

enum OperationalStatus: String, Codable {
    case active = "Active"
    case retired = "Retired"
    case refurbishment = "Refurbishment"
    
    func getBackgroundColor() -> Color {
        switch self {
        case .active:
            return Color.green
        case .retired:
            return Color.red
        case .refurbishment:
            return Color.yellow
        }
    }
}
