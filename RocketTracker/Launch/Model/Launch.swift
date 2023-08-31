//
//  Launch.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/14/23.
//

import Foundation
import SwiftUI

/*
 JSON Format
 {
     "id" : "",
     "missionName" : "",
     "altMissionName" : "",
     "abbrMissionName" : "",
     "liftOffTime" : "YYYY-MM-DDThh:mm:ss+0000",
     "orbitalDestination" : "",
     "launchProvider" : "",
     "launchSiteName" : "",
     "launchSitePad" : "",
     "vehicleName" : "",
     "vehicleVariant" : "",
     "missionOutcome" : "",
     "crewedLaunch" : "",
     "staticFireGap" : "",
     "boosterName" : [""],
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
     "payloadDescription" : [""],
     "livestreamLink" : "",
 },
 */

struct Launch: Identifiable, Equatable, Codable {
    let cosparCode: String
    let missionName: String
    let altMissionName: String
    let abbrMissionName: String
    let liftOffTime: String
    let orbitalDestination: OrbitDestination
    let launchProvider: String
    let launchSite: String
    let launchSitePad: String
    let vehicleName: String
    let vehicleVariant: String
    let missionOutcome: Outcome
    
    let crewedLaunch: String
    let staticFireGap: String
    let boosterData: [String]
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
    //Case 1 - Future: <Launch Provider> are targeting no earlier than <Day of the Week>, <Month> <Day> at <Time hh:mm> <Time Abbreviation x.m.> <TimeZone in LaunchSite LocalTime>, (<Time hh:mm> UTC), for <Launch Vehicle>'s launch to <OrbitDestination> from <LaunchSitePad Full Name> (LaunchSitePad) at <LaunchSite Full Name> in <LaunchSite State>. This mission is launching
    // SpaceX are targeting no earlier than Friday, August 25 at 3:50 a.m. EST, (7:50 UTC), for Falcon 9's launch to International Space Station from Launch Complex 39A (LC-39A) at Kennedy Space Center in Florida. This mission is launching
    
    //Case 2 - Past: On <Day of the Week>, <Month> <Day> at <Time hh:mm> <Time Abbreviation x.m.> <TimeZone in LaunchSite LocalTime>, (<Time hh:mm> UTC), <Launch Provider> <MissionOutcome> launched <LaunchVehicle> from <LaunchSitePad Full Name> (LaunchSitePad) at <LaunchSite Full Name> in <LaunchSite State>. This mission launched 
    // On Saturday, June 13 at 5:21 a.m. EDT, (9:21 UTC), SpaceX successfully launched Falcon 9 from Space Launch Complex 40 (SLC-40) at Cape Canaveral Space Force Station in Florida. This mission launched
    
    //Case 3 - In Flight:
    let livestreamLink: String
    
    var id: String {
        cosparCode + " + " + missionName
    }
    
    var time: Time {
        missionOutcome.determineTime()
    }
    
    var staticFire: Bool {
        staticFireGap.isEmpty ? false : true
    }
    
    var boosterNames: [String] {
        generateBoosterNames(data: boosterData)
    }
    
    var numberOfFlights: [Int] {
        generateNumberOfFlights(data: boosterData)
    }
    
    //Equatable
    static func == (lhs: Launch, rhs: Launch) -> Bool {
        lhs.id == rhs.id
    }
    
    func generateBoosterNames(data: [String]) -> [String] {
        var returnedArray: [String] = []
        for booster in data {
            let components = booster.components(separatedBy: "-")
            returnedArray.append(components[0])
        }
        return returnedArray
    }
    
    func generateNumberOfFlights(data: [String]) -> [Int] {
        var returnedArray: [Int] = []
        for booster in data {
            let components = booster.components(separatedBy: "-")
            returnedArray.append(Int(components[1])!)
        }
        return returnedArray
    }
    
    
}

enum OrbitDestination: String, Codable {
    case leo = "LEO" //Low Earth Orbit
    case pleo = "PLEO" //Polar Low Earth Orbit
    case plro = "PLRO" //Polar Orbit
    case meo = "MEO" //Medium Earth Orbit
    case geo = "GEO" //Geostationary Equatorial Orbit
    case gto = "GTO" //Geostationary Transfer Orbit
    case iss = "ISS" //International Space Station
    case sso = "SSO" //Sun-Synchronous Orbit
    case heo = "HEO" //High Earth Orbit
    case helo = "HELO" //Highly Elliptical Orbit
    case sub = "SUB" //Suborbital Trajectory
    case tli = "TLI" //Trans-Lunar Injection Orbit
    case sel1 = "SEL1" //Sun-Earth Lagrange Point 1
    case sel2 = "SEL2" //Sun-Earth Lagrange Point 2
    case helio = "HELIO" //Heliocentric Orbit
    case notAvailable = "NA"
    
    func getFullName() -> String {
        switch self {
        case .leo:
            return "Low Earth Orbit"
        case .pleo:
            return "Polar Low Earth Orbit"
        case .plro:
            return "Polar Orbit"
        case .meo:
            return "Medium Earth Orbit"
        case .geo:
            return "Geostationary Equatorial Orbit"
        case .gto:
            return "Geostationary Transfer Orbit"
        case .iss:
            return "International Space Station"
        case .sso:
            return "Sun Synchronous Orbit"
        case .heo:
            return "High Earth Orbit"
        case .helo:
            return "Highly Elliptical Orbit"
        case .sub:
            return "Suborbital Trajectory"
        case .tli:
            return "Trans-Lunar Injection Orbit"
        case .sel1:
            return "Sun-Earth Lagrange Point 1"
        case .sel2:
            return "Sun-Earth Lagrange Point 2"
        case .helio:
            return "Heliocentric Orbit"
        case .notAvailable:
            return "Not Available"
        }
    }
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
    case inFlight = "In Flight"
    case partialSuccess = "Partial Success"
    case success = "Success"
    case transit = "Transit"
    case unknown = "Unknown"
    case upcoming = "Upcoming"
    case notAvailable = "NA"
    
    func determineTime() -> Time {
        switch self {
        case .upcoming, .inFlight:
            return .future
        case .aborted, .explosion, .failure, .partialSuccess, .success, .transit, .unknown, .notAvailable:
            return .past
        }
    }
    
    func getBackgroundColor() -> Color {
        switch self {
        case .aborted:
            return Color.yellow
        case .explosion:
            return Color.orange
        case .failure:
            return Color.red
        case .inFlight:
            return Color.purple
        case .partialSuccess:
            return Color.mint
        case .success:
            return Color.green
        case .transit:
            return Color.blue
        case .unknown:
            return Color.gray
        case .upcoming:
            return Color.cyan
        case .notAvailable:
            return Color.clear
        }
    }
    
    func getMissionOutcomeDescription() -> String {
        switch self {
        case .explosion:
            return "Exploded before the launch began"
        case .failure:
            return "The launch experienced a failure in flight"
        case .inFlight:
            return "Launch is currently still in flight"
        case .partialSuccess:
            return "Not all payloads were deployed successfully"
        case .success:
            return "Launch was succesfully completed"
        case .upcoming:
            return "Launch has not happened yet"
        default:
            return ""
        }
    }
}

enum Time: String {
    case past = "Past"
    case future = "Future"
    
    //Return a Boolean for the Launch Data Validation Tree
    func getBool() -> Bool {
        
        // If launch was in the past return true to run through a more stringent set of data validation. If in the future, data can be missing so return false
        switch self {
        case .future:
            return false
        case .past:
            return true
        }
    }
}

