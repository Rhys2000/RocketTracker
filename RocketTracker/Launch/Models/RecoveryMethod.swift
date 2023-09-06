//
//  RecoveryMethod.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/3/23.
//

import Foundation

enum RecoveryMethod: String, Codable {
    case droneship = "Droneship"
    case expended = "Expended"
    case hoverslam = "Hoverslam"
    case netCatch = "Catch"
    case parachute = "Parachute"
    case returnToLaunchSite = "RTLS"
    case splashdown = "Splashdown"
    case notAvailable = "NA"
    
    func upcomingFairingMethod(location: String) -> String {
        switch self {
        case .netCatch:
            return "be caught by \(location)"
        case .splashdown:
            return "splashdown in the \(location) ocean"
        case .expended:
            return "expended"
        default:
            print("I have an error")
            return "Error"
        }
    }
    
    func previousFairingMethod() -> String {
        switch self {
        case .netCatch:
            return "caught"
        case .splashdown:
            return "splashed down"
        default:
            print("I have an error")
            return "Error"
        }
    }
}
