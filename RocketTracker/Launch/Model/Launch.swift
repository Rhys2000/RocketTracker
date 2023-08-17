//
//  Launch.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/14/23.
//

import Foundation

/*
 JSON Format
 {
     "id" : "",
     "mission_name" : "",
     "alternative_mission_name" : "",
     "abbreviated_mission_name" : "",
     "lift_off_time" : "",
     "orbital_destination" : "",
     "launch_provider" : "",
     "launch_site_name" : "",
     "launch_site_pad" : "",
     "vehicle_name" : "",
     "vehicle_variant" : "",
     "mission_outcome" : "",
     "crewed_launch" : ,
     "static_fire" : ,
     "static_fire_to_launch_window" : ,
     "booster_name" : [""],
     "booster_recovery_attempted" : [],
     "booster_recovery_method" : [""],
     "booster_recovery_location" : [""],
     "booster_recovery_distance" : [],
     "booster_recovery_outcome" : [""],
     "number_of_fairing_flights" : [],
     "fairing_recovery_attempted" : [],
     "fairing_recovery_method" : [""],
     "fairing_recovery_location" : [""],
     "fairing_recovery_distance" : [],
     "fairing_recovery_outcome" : [""],
     "support_vessel" : [""],
     "support_vessel_roles" : [[""]],
     "description" : [""],
     "livestream_link" : "",
 }
 */

struct Launch: Identifiable, Codable {
    let id: String
    let missionName: String
    let alternativeMissionName: String?
    let abbreviatedMissionName: String?
    let liftOffTime: String
    let orbitalDestination: OrbitDestination
    let launchProvider: LaunchProvider
    let launchSiteName: String
    let launchSitePad: String
    let vehicleName: String
    let vehicleVariant: String
    let missionOutcome: MissionOutcome
    
    let crewedLaunch: Bool?
    let staticFire: Bool?
    let staticFireToLaunchWindow: Int?
    let boosterName: [String?]
    let boosterRecoveryAttempted: [Bool]
    let boosterRecoveryMethod: [RecoveryMethod?]
    let boosterRecoveryLocation: [String?]
    let boosterRecoveryDistance: [Double?]
    let boosterRecoveryOutcome: [RecoveryOutcome?]
    let numberOfFairingFlights: [Int?]
    let fairingRecoveryAttempted: [Bool]
    let fairingRecoveryMethod: [RecoveryMethod?]
    let fairingRecoveryLocation: [String?]
    let fairingRecoveryDistance: [Double?]
    let fairingRecoveryOutcome: [RecoveryOutcome?]
    let supportVessel: [String?]
    let supportVesselRole: [[VesselRole?]]
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

