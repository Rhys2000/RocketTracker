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
    
//    func recoveryMethodBooster(launch: Launch, index: Int) -> String {
//        let time = launch.time.getBool()
//        switch self {
//        case .droneship:
//            return time ? "\(launch.boosterRecoveryOutcome[index].getDronehsipOutcome()) the booster \(launch.boosterRecoveryDistance[index]) km downrange aboard the droneship \(launch.boosterRecoveryLocation[index])" : "Will attempt to land \(launch.boosterRecoveryDistance[index]) km downrange aboard the droneship \(launch.boosterRecoveryLocation[index])"
//        case .expended:
//            return time ? "The booster was expended during this launch" : "The booster will be expended after this launch"
//        case .hoverslam:
//            return time ? "Performed a hoverslam \(launch.boosterRecoveryDistance[index]) km downrange in the \(launch.boosterRecoveryLocation[index]) to gather landing data" : "Will perform a hoverslam \(launch.boosterRecoveryDistance[index]) km downrange in the \(launch.boosterRecoveryLocation[index]) to gather landing data"
//        case .parachute:
//            return time ? "\(launch.boosterRecoveryOutcome[index].getDronehsipOutcome()) the booster softly \(launch.boosterRecoveryDistance[index]) km downrange in the \(launch.boosterRecoveryLocation[index]) using parachutes" : "Will attempt to land the booster softly \(launch.boosterRecoveryDistance[index]) km downrange in the \(launch.boosterRecoveryLocation[index]) using parachutes"
//        case .returnToLaunchSite:
//            return time ? "\(launch.boosterRecoveryOutcome[index].getReturnToLaunchSiteOutcome()) a Return to Launch Site maneuver and land \(launch.boosterRecoveryDistance[index]) km downrange at \(launch.boosterRecoveryLocation[index])" : "Will perform a Return to Launch Site maneuver and attempt to land \(launch.boosterRecoveryDistance[index]) km downrange at \(launch.boosterRecoveryLocation[index])"
//        default:
//            return ""
//        }
//    }
}
