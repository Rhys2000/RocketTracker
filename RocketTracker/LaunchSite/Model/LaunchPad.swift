//
//  LaunchPad.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/3/23.
//

import Foundation

struct LaunchPad: Identifiable, Codable {
    
    let shortName: String
    let fullName: String
    let operatorName: String
    let status: CustomStatus
    let latitude: Double
    let longitude: Double
    
    var id: String { shortName }
    
    func getLaunchPadFullName() -> String {
        return "\(fullName) (\(shortName))"
    }
}
