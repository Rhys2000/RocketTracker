//
//  Outcome.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/3/23.
//

import Foundation
import SwiftUI

enum Outcome: String, Codable {
    case aborted = "Aborted"
    case explosion = "Explosion"
    case failure = "Failure"
    case inFlight = "In Flight"
    case partialSuccess = "Partial Success"
    case success = "Success"
    case transit = "Transit"
    case unknown = "Unknown"
    case upcoming = "Upcoming"
    case notAvailable = "NA"
    
//    func getDronehsipOutcome() -> String {
//        switch self {
//        case .success:
//            return "Successfully landed"
//        case .failure:
//            return "Failed to land"
//        default:
//            return ""
//        }
//    }
//    
//    func getReturnToLaunchSiteOutcome() -> String {
//        switch self {
//        case .success:
//            return "Successfully performed"
//        case .failure:
//            return "Failed to perform"
//        default:
//            return ""
//        }
//    }
//    
//    func getBackgroundColor() -> Color {
//        switch self {
//        case .aborted:
//            return Color.yellow
//        case .explosion:
//            return Color.orange
//        case .failure:
//            return Color.red
//        case .inFlight:
//            return Color.purple
//        case .partialSuccess:
//            return Color.mint
//        case .success:
//            return Color.green
//        case .transit:
//            return Color.blue
//        case .unknown:
//            return Color.gray
//        case .upcoming:
//            return Color.cyan
//        case .notAvailable:
//            return Color.clear
//        }
//    }
//    
//    func getLaunchOutcomeDescription() -> String {
//        switch self {
//        case .explosion:
//            return "Exploded before the launch began"
//        case .failure:
//            return "The launch experienced a failure in flight"
//        case .inFlight:
//            return "Launch is currently still in flight"
//        case .partialSuccess:
//            return "Not all payloads were deployed successfully"
//        case .success:
//            return "Launch was succesfully completed"
//        case .upcoming:
//            return "Launch has not happened yet"
//        default:
//            return ""
//        }
//    }
}
