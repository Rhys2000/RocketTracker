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
     "missionName" : "",
     "alternativeMissionName" : "",
     "abbreviatedMissionName" : "",
     "liftOffTime" : "YYYY-MM-DDThh:mm:ss+0000",
     "orbitalDestination" : "",
     "launchProvider" : "SpaceX",
     "launchSiteName" : "",
     "launchSitePad" : "",
     "vehicleName" : "Falcon 9",
     "vehicleVariant" : "Block ",
     "missionOutcome" : "",
     "crewedLaunch" : ,
     "staticFire" : ,
     "staticFireToLaunchWindow" : ,
     "boosterName" : [""],
     "boosterRecoveryAttempted" : [],
     "boosterRecoveryMethod" : [""],
     "boosterRecoveryLocation" : [""],
     "boosterRecoveryDistance" : [],
     "boosterRecoveryOutcome" : [""],
     "numberOfFairingFlights" : [],
     "fairingRecoveryAttempted" : [],
     "fairingRecoveryMethod" : [""],
     "fairingRecoveryLocation" : [""],
     "fairingRecoveryDistance" : [],
     "fairingRecoveryOutcome" : [""],
     "supportVessel" : [""],
     "supportVesselRole" : [[""]],
     "description" : [""],
     "livestreamLink" : "",
 },
 */

struct Launch: Identifiable, Codable {
    let id: String
    let missionName: String
    let alternativeMissionName: String
    let abbreviatedMissionName: String
    let liftOffTime: String
    let orbitalDestination: OrbitDestination
    let launchProvider: LaunchProvider
    let launchSiteName: String
    let launchSitePad: String
    let vehicleName: String
    let vehicleVariant: String
    let missionOutcome: Outcome
    
    let crewedLaunch: Bool
    let staticFire: Bool
    let staticFireToLaunchWindow: Int
    let boosterName: [String]
    let boosterRecoveryAttempted: [Bool]
    let boosterRecoveryMethod: [RecoveryMethod?]
    let boosterRecoveryLocation: [String]
    let boosterRecoveryDistance: [Double]
    let boosterRecoveryOutcome: [Outcome]
    let numberOfFairingFlights: [Int]
    let fairingRecoveryAttempted: [Bool]
    let fairingRecoveryMethod: [RecoveryMethod]
    let fairingRecoveryLocation: [String]
    let fairingRecoveryDistance: [Double]
    let fairingRecoveryOutcome: [Outcome]
    let supportVessel: [String]
    let supportVesselRole: [[VesselRole]]
    let description: [String?]
    let livesteamLink: String?
}

enum OrbitDestination: String, Codable {
    case leo = "LEO" //Low Earth Orbit
    case pleo = "PLEO" //Polar Low Earth Orbit
    case meo = "MEO" //Medium Earth Orbit
    case geo = "GEO" //Geostationary Equatorial Orbit
    case gto = "GTO" //Geostationary Transfer Orbit
    case iss = "ISS" //International Space Station
    case sso = "SSO" //Sun-Synchronous Orbit
    case heo = "HEO" //High Earth Orbit
    case sub = "SUB" //Suborbital Trajectory
    case tli = "TLI" //Trans-Lunar Injection Orbit
    case sel1 = "SEL1" //Sun-Earth Lagrange Point 1
}

enum LaunchProvider: String, Codable {
    case spacex = "SpaceX"
}

enum RecoveryMethod: String, Codable {
    case expended = "Expended"
    case parachute = "Parachute"
    case splashdown = "Splashdown"
    case returnToLaunchSite = "RTLS"
    case droneship = "Droneship"
    case netCatch = "Catch"
    case notAvailable = "NA"
}

enum Outcome: String, Codable {
    case success = "Success"
    case partialSuccess = "Partial Success"
    case failure = "Failure"
    case prelaunchExplosion = "Prelaunch Explosion"
    case unknown = "Unknown"
    case notAvailable = "NA"
}

