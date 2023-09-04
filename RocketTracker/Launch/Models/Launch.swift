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
     "launchSiteShortName" : "",
     "launchPadAbbr" : "",
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
    let launchSiteShortName: String
    let launchPadAbbr: String
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
    let numberOfFairingFlights: [String]
    let fairingRecoveryMethod: [RecoveryMethod]
    let fairingRecoveryLocation: [String]
    let fairingRecoveryDistance: String
    let fairingRecoveryOutcome: [Outcome]
    let supportVessel: [String]
    let supportVesselRole: [[VesselRole]]
    let description: [String]
    let livestreamLink: String
    
    var id: String { missionName }
    
    var pastLaunch: Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let launchDate = dateFormatter.date(from: liftOffTime)!
        let currentTime = Date.now
        
        //If currentTime is prior to launch date, set pastLaunch to false, otherwise set to true
        return currentTime < launchDate ? true : false
    }
    
    var boosters: [Booster] {
        var boosterArray: [Booster] = []
        
        for index in 0..<self.boosterData.count {
            var booster: Booster = Booster()
            
            let components = self.boosterData[index].components(separatedBy: "-")
            booster.name = components[0]
            booster.flightNumber = components[1]
            
            booster.method = self.boosterRecoveryMethod[index]
            booster.location = self.boosterRecoveryLocation[index]
            booster.distance = self.boosterRecoveryDistance[index]
            booster.outcome = self.boosterRecoveryOutcome[index]
            
            boosterArray.append(booster)
        }
        return boosterArray
    }
    
    var fairings: [Fairing] {
        var fairingArray: [Fairing] = []
        
        for index in 0..<self.numberOfFairingFlights.count {
            var fairing: Fairing = Fairing()
            
            fairing.flightNumber = self.numberOfFairingFlights[index]
            fairing.method = self.fairingRecoveryMethod[index]
            fairing.location = self.fairingRecoveryLocation[index]
            fairing.distance = self.fairingRecoveryDistance
            fairing.outcome = self.fairingRecoveryOutcome[index]
            
            fairingArray.append(fairing)
        }
        
        return fairingArray
    }

//    var staticFire: Bool {
//        staticFireGap.isEmpty ? false : true
//    }
//
//    //Equatable
//    static func == (lhs: Launch, rhs: Launch) -> Bool {
//        lhs.id == rhs.id
//    }
//
    
}

