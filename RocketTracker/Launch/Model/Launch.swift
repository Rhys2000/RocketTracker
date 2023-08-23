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
     "staticFireGap" : "",
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
    let staticFireGap: String
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
    let payloadDescription: [String]
    //Case 1 - Future: <Launch Provider> are targeting no earlier than <Day of the Week>, <Month> <Day> at <Time hh:mm> <Time Abbreviation x.m.> <TimeZone in LaunchSite LocalTime>, (<Time hh:mm> UTC), for <Launch Vehicle>'s launch to <OrbitDestination> from <LaunchSitePad Full Name> (LaunchSitePad) at <LaunchSite Full Name> in <LaunchSite State>. This mission is launching
    // SpaceX are targeting no earlier than Friday, August 25 at 3:50 a.m. EST, (7:50 UTC), for Falcon 9's launch to International Space Station from Launch Complex 39A (LC-39A) at Kennedy Space Center in Florida. This mission is launching
    
    //Case 2 - Past: On <Day of the Week>, <Month> <Day> at <Time hh:mm> <Time Abbreviation x.m.> <TimeZone in LaunchSite LocalTime>, (<Time hh:mm> UTC), <Launch Provider> <MissionOutcome> launched <LaunchVehicle> from <LaunchSitePad Full Name> (LaunchSitePad) at <LaunchSite Full Name> in <LaunchSite State>. This mission launched 
    // On Saturday, June 13 at 5:21 a.m. EDT, (9:21 UTC), SpaceX successfully launched Falcon 9 from Space Launch Complex 40 (SLC-40) at Cape Canaveral Space Force Station in Florida. This mission launched
    
    //Case 3 - In Flight:
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

