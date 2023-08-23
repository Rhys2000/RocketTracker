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
     "vehicleVariant" : "Block 5",
     "missionOutcome" : "Success",
     "crewedLaunch" : "",
     "staticFire" : "",
     "staticFireToLaunchWindow" : "",
     "boosterName" : ["B"],
     "boosterRecoveryMethod" : [""],
     "boosterRecoveryLocation" : [""],
     "boosterRecoveryDistance" : [""],
     "boosterRecoveryOutcome" : [""],
     "numberOfFairingFlights" : ["", ""],
     "fairingRecoveryMethod" : ["", ""],
     "fairingRecoveryLocation" : ["", ""],
     "fairingRecoveryDistance" : "",
     "fairingRecoveryOutcome" : ["", ""],
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
    
    let crewedLaunch: String
    let staticFire: String
    let staticFireToLaunchWindow: String
    let boosterName: [String]
    let boosterRecoveryMethod: [RecoveryMethod]
    let boosterRecoveryLocation: [String]
    let boosterRecoveryDistance: [String]
    let boosterRecoveryOutcome: [Outcome]
    let numberOfFairingFlights: [String] //Look for values of 0
    let fairingRecoveryMethod: [RecoveryMethod]
    let fairingRecoveryLocation: [String]
    let fairingRecoveryDistance: String
    let fairingRecoveryOutcome: [Outcome]
    let supportVessel: [String]
    let supportVesselRole: [[VesselRole]]
    let description: [String]
    let livestreamLink: String
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
    case sel2 = "SEL2" //Sun-Earth Lagrange Point 2
    case helio = "HELIO" //Heliocentric Orbit
}

enum LaunchProvider: String, Codable {
    case spacex = "SpaceX"
}

enum RecoveryMethod: String, Codable {
    case droneship = "Droneship"
    case expended = "Expended"
    case hoverslam = "Hoverslam"
    case netCatch = "Catch"
    case parachute = "Parachute"
    case returnToLaunchSite = "RTLS"
    case splashdown = "Splashdown"
    case notAvailable = "NA"
}

enum Outcome: String, Codable {
    case aborted = "Aborted"
    case explosion = "Explosion"
    case failure = "Failure"
    case partialSuccess = "Partial Success"
    case success = "Success"
    case transit = "Transit"
    case unknown = "Unknown"
    case notAvailable = "NA"
}

