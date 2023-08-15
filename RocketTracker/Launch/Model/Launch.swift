//
//  Launch.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/14/23.
//

import Foundation

struct Launch: Identifiable, Codable {
    let id: String
    let missionName: String
    let alternativeMissionName: String?
    let abbreviatedMissionName: String?
    let liftOffTime: String
    let orbitalDestination: OrbitDestination
    let launchProvider: LaunchProvider
    let launchSite: String?
    let launchPad: String?
    let vehicleName: String
    let vehicleVariant: String
    let missionStatus: MissionOutcome
    
    let crewedLaunch: Bool?
    let staticFire: Bool?
    let staticFireToLaunchWindow: Int?
    let boosterID: [String?]
    let boosterRecoveryAttempted: [Bool?]
    let boosterRecoveryMethod: [RecoveryMethod?]
    let boosterRecoveryLocation: [String?]
    let boosterRecoveryDistance: [Double?]
    let boosterRecoveryOutcome: [RecoveryOutcome?]
    let numberOfFairingFlights: [Int?]
    let fairingRecoveryAttempted: [Bool?]
    let fairingRecoveryMethod: [RecoveryMethod?]
    let fairingRecoveryLocation: [String?]
    let fairingRecoveryDistance: [Double?]
    let fairingRecoveryOutcome: [RecoveryOutcome?]
    let supportVessel: [String?]
    let supportVesselRoles: [[VesselRole?]]
    let description: [String?]
    let livesteamLink: String?
}

enum OrbitDestination: String, Codable {
    case leo = "LEO"
}

enum LaunchProvider: String, Codable {
    case spacex = "SpaceX"
}

enum RecoveryMethod: String, Codable {
    case rtls = "RTLS"
}

enum RecoveryOutcome: String, Codable {
    case success = "Success"
}

enum MissionOutcome: String, Codable {
    case failure = "Failure"
}

enum VesselRole: String, Codable {
    case dsv = "DSV"
}

