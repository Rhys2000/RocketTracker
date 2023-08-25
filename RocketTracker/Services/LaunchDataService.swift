//
//  LaunchDataService.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/17/23.
//

import Foundation
import Combine
import SwiftUI

class LaunchDataService {
    
    @Published var pastLaunches: [Launch] = []
    @Published var futureLaunches: [Launch] = []
    
    var allLaunches: [Launch] = []
    private var showValidationSteps: Bool = false
    
    private let knownLaunchSite: [String: Set<String>] = ["Kennedy": ["LC-39A"], "Cape Canaveral": ["SLC-40"], "Vandenberg": ["SLC-4E"]]
    private let unknownLaunchSite: [String: Set<String>] = ["Florida": [""]]
    
    private let launchProviders: [String: [String: [String]]] = [
        "SpaceX": [
            "Falcon 9": ["Block 1", "Block 2", "Block 3", "Block 4", "Block 5"],
            "Falcon Heavy": [""]
        ],
    ]
    
    init() {
        loadLaunches()
        validateLaunchData()
        divideLaunchesByDate()
    }
    
    private func loadLaunches() {
        if let fileLocation = Bundle.main.url(forResource: "spacex", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                self.allLaunches = try jsonDecoder.decode([Launch].self, from: data)
            } catch {
                print(error)
            }
        }
    }
    
    private func divideLaunchesByDate() {
        for launch in allLaunches {
            (launch.time == .future) ? futureLaunches.append(launch) : pastLaunches.append(launch)
        }
        
    }
    
    private func validateLaunchData() {
        
        //Iterate through each launch in the list of launches (allLaunches)
        for (launch, launchNumber) in zip(allLaunches, 0..<allLaunches.count) {
            
            //Change
            showValidationSteps ? print("\n\n\n*--- Validating Launch: \(launch.missionName) ---*\n") : nil
            
            
            let cosparBool = validateCosparCode(time: launch.time, cosparCode: launch.cosparCode)
            let nameBool = validateMissionNames(missionName: launch.missionName, altMissionName: launch.altMissionName, abbrMissionName: launch.abbrMissionName)
            let liftOffBool = validateLiftOffTime(liftOffTime: launch.liftOffTime)
            let orbitBool = validateOrbitDestination(time: launch.time, orbitDestination: launch.orbitalDestination)
            let launchSiteBool = validateLaunchSite(time: launch.time, launchSite: launch.launchSite, launchSitePad: launch.launchSitePad)
            let providerBool = validateLaunchVehicleAndProvider(launchProvider: launch.launchProvider, vehicleName: launch.vehicleName, vehicleVariant: launch.vehicleVariant)
            let missionBool = validateMissionOutcome(time: launch.time, missionOutcome: launch.missionOutcome)
            let crewBool = validateCrewedMission(crewedLaunch: launch.crewedLaunch)
            let staticBool = validateStaticFire(time: launch.time, staticFireGap: launch.staticFireGap)
            let boosterNameBool = validateBoosterName(boosterNames: launch.boosterName)
            
            
            if(!cosparBool || !nameBool || !liftOffBool || !orbitBool || !launchSiteBool || !providerBool || !missionBool || !crewBool || !staticBool || !boosterNameBool) {
                print("\(launchNumber): \(launch.id) -> \(cosparBool), \(nameBool), \(liftOffBool), \(orbitBool), \(launchSiteBool), \(providerBool), \(missionBool), \(crewBool), \(staticBool), \(boosterNameBool)\n\n\n")
            }
        }
    }
    
    private func validateCosparCode(time: Time, cosparCode: String) -> Bool {
        
        showValidationSteps ? print("Cospar Code Section") : nil
        
        //Past Launches
        if(time.getBool()) {
            
            //Check to make sure that cosparCode is the right length
            showValidationSteps ? print("\tValue: (\(cosparCode)) -> Count: \(cosparCode.count), isNotEmpty: \(!cosparCode.isEmpty)") : nil
            if(cosparCode.count != 8 || cosparCode.isEmpty) {
                return false
            }
            
            //Check to make sure the first 4 characters in cosparCode are made of numbers (0-9)
            var currentString = cosparCode.subString(from: 0, to: 4)
            showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit)") : nil
            if(!currentString.isDigit) {
                return false
            }
            
            //Change. Add additional check that cosparCode is equal to year within liftOffTime
            
            //Check to make sure the fifth character in cosparCode is equal to "-"
            currentString = cosparCode.subString(from: 4, to: 5)
            showValidationSteps ? print("\tValue: (\(currentString)) -> isEqual: \(currentString.isEqual("-"))") : nil
            if(!currentString.isEqual("-")) {
                return false
            }
            
            //Check to make sure the sixth character in cosparCode is either a number (0-9) and the sixth character is not an uppercase english letter
            currentString = cosparCode.subString(from: 5, to: 6)
            showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit), isCapitalLetter: \(currentString.isCapitalLetter)") : nil
            if(!currentString.isDigit && !currentString.isCapitalLetter) {
                return false
            }
            
            //Check to make sure the last two characters in cosparCode are made of numbers (0-9)
            currentString = cosparCode.subString(from: 6, to: 8)
            showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit)") : nil
            if(!currentString.isDigit) {
                return false
            }
        }
        
        else {
            
            //Check to make sure that cosparCode is empty (blank string)
            showValidationSteps ? print("\tValue: (\(cosparCode)) -> isEmpty: \(cosparCode.isEmpty)") : nil
            if(!cosparCode.isEmpty) {
                return false
            }
        }
        
        return true
    }
    
    private func validateMissionNames(missionName: String, altMissionName: String, abbrMissionName: String) -> Bool {
        
        showValidationSteps ? print("Mission Name Section") : nil
        
        //Check to make sure that there is a value inside of missionName
        showValidationSteps ? print("\tValue: (\(missionName)) -> isNotEmpty: \(!missionName.isEmpty)") : nil
        if(missionName.isEmpty) {
            return false
        }
        
        //Check to make sure that if there is a value inside of abbrevMissionName there is also one inside of missionName
        showValidationSteps ? print("\tValue: (\(abbrMissionName)) -> isNotEmpty: \(!abbrMissionName.isEmpty), so (missionName) isNotEmpty: \(!missionName.isEmpty)") : nil
        if(missionName.isEmpty && !abbrMissionName.isEmpty) {
            return false
        }
        
        //Check to make sure that if there is a value inside of altMissionName there is also one inside of missionName
        showValidationSteps ? print("\tValue: (\(altMissionName)) -> isNotEmpty: \(!altMissionName.isEmpty), so (missionName) isNotEmpty: \(!missionName.isEmpty)") : nil
        if(missionName.isEmpty && !altMissionName.isEmpty) {
            return false
        }
        
        return true
    }
    
    private func validateLiftOffTime(liftOffTime: String) -> Bool {
        
        showValidationSteps ? print("Lift Off Time Section") : nil
        
        //Check to make sure that liftOffTime is the right length and is not an empty string
        showValidationSteps ? print("\tValue: (\(liftOffTime)) -> Count: \(liftOffTime.count), isNotEmpty: \(!liftOffTime.isEmpty)") : nil
        if(liftOffTime.count != 24 || liftOffTime.isEmpty) {
            return false
        }
        
        //Check to make sure that the first 4 characters in liftOffTime are made of digits (0-9)
        var currentString = liftOffTime.subString(from: 0, to: 4)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit), isBetween: \(currentString.isBetween(2010, 2028))") : nil
        if(!currentString.isDigit && !currentString.isBetween(2010, 2028)) {
            return false
        }
        
        currentString = liftOffTime.subString(from: 4, to: 5)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isEqual: \(currentString.isEqual("-"))") : nil
        if(!currentString.isEqual("-")) {
            return false
        }
        
        currentString = liftOffTime.subString(from: 5, to: 7)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit), isBetween: \(currentString.isBetween(1, 12))") : nil
        if(!currentString.isDigit && !currentString.isBetween(1, 12)) {
            return false
        }
        
        currentString = liftOffTime.subString(from: 7, to: 8)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isEqual: \(currentString.isEqual("-"))") : nil
        if(!currentString.isEqual("-")) {
            return false
        }
        
        currentString = liftOffTime.subString(from: 8, to: 10)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit), isBetween: \(currentString.isBetween(1, 31))") : nil
        if(!currentString.isDigit && !currentString.isBetween(1, 31)) {
            return false
        }
        
        currentString = liftOffTime.subString(from: 10, to: 11)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isCapitalLetter: \(currentString.isCapitalLetter)") : nil
        if(!currentString.isCapitalLetter) {
            return false
        }
        
        currentString = liftOffTime.subString(from: 11, to: 13)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit), isBetween: \(currentString.isBetween(0, 24))") : nil
        if(!currentString.isDigit && !currentString.isBetween(0, 24)) {
            return false
        }
        
        currentString = liftOffTime.subString(from: 13, to: 14)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isEqual: \(currentString.isEqual(":"))") : nil
        if(!currentString.isEqual(":")) {
            return false
        }
        
        currentString = liftOffTime.subString(from: 14, to: 16)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit), isBetween: \(currentString.isBetween(0, 59))") : nil
        if(!currentString.isDigit && !currentString.isBetween(0, 59)) {
            return false
        }
        
        currentString = liftOffTime.subString(from: 16, to: 17)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isEqual: \(currentString.isEqual(":"))") : nil
        if(!currentString.isEqual(":")) {
            return false
        }
        
        currentString = liftOffTime.subString(from: 17, to: 19)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit), isBetween: \(currentString.isBetween(0, 59))") : nil
        if(!currentString.isDigit && !currentString.isBetween(0, 59)) {
            return false
        }
        
        currentString = liftOffTime.subString(from: 19, to: 20)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isEqual: \(currentString.isEqual("+"))") : nil
        if(!currentString.isEqual("+")) {
            return false
        }
        
        currentString = liftOffTime.subString(from: 20, to: 24)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit), isEqual: \(currentString.isEqual("0000"))") : nil
        if(!currentString.isDigit && currentString.isEqual("0000")) {
            return false
        }
        
        return true

    }
    
    private func validateOrbitDestination(time: Time, orbitDestination: OrbitDestination) -> Bool {
        
        showValidationSteps ? print("Orbit Destination Section") : nil
        
        showValidationSteps ? print("\tValue: (\(orbitDestination.rawValue)) isNotEmpty: \(!orbitDestination.rawValue.isEmpty)") : nil
        if(orbitDestination.rawValue.isEmpty) {
            return false
        }
        
        if(time.getBool()) {
            
            showValidationSteps ? print("\tValue: (\(orbitDestination.rawValue)) isAvailable: \(orbitDestination != .notAvailable)") : nil
            if(orbitDestination == .notAvailable) {
                return false
            }
        }
        
        return true
    }
    
    private func validateLaunchSite(time: Time, launchSite: String, launchSitePad: String) -> Bool {
        
        showValidationSteps ? print("Launch Site Section") : nil
        
        if(time.getBool()) {
            showValidationSteps ? print("\tValue: (\(launchSite)) isNotEmpty: \(!launchSite.isEmpty), hasLaunchSite: \(hasLaunchSite(time, launchSite))") : nil
            if(launchSite.isEmpty && !hasLaunchSite(time, launchSite)) {
                return false
            }
            
            showValidationSteps ? print("\tValue: (\(launchSitePad)) isNotEmpty: \(!launchSitePad.isEmpty), hasLaunchPad: \(hasLaunchPad(time, launchSite, launchSitePad))") : nil
            if(launchSitePad.isEmpty && !hasLaunchPad(time, launchSite, launchSitePad)) {
                return false
            }
        }
        
        else {
            showValidationSteps ? print("\tValue: (\(launchSite)) isNotEmpty: \(!launchSite.isEmpty), hasLaunchSite: \(hasLaunchSite(time, launchSite))") : nil
            if(launchSite.isEmpty && !hasLaunchSite(time, launchSite)) {
                return false
            }
        }
            
        
        return true
    }
    
    private func validateLaunchVehicleAndProvider(launchProvider: String, vehicleName: String, vehicleVariant: String) -> Bool {
        
        showValidationSteps ? print("Launch Provider and Vehicle Section") : nil
        
        showValidationSteps ? print("\tValue: (\(launchProvider)) isNotEmpty: \(!launchProvider.isEmpty), hasLaunchProvider: \(hasLaunchProvider(launchProvider))") : nil
        if(!launchProvider.isEmpty && !hasLaunchProvider(launchProvider)) {
            return false
        }
        
        showValidationSteps ? print("\tValue: (\(vehicleName)) isNotEmpty: \(!vehicleName.isEmpty), hasVehicleName: \(hasVehicleName(launchProvider, vehicleName))") : nil
        if(!launchProvider.isEmpty && !hasVehicleName(launchProvider, vehicleName)) {
            return false
        }
        
        showValidationSteps ? print("\tValue: (\(vehicleVariant)) hasVehicleVariant: \(hasVehicleVariant(launchProvider, vehicleName, vehicleVariant))") : nil
        if(!hasVehicleVariant(launchProvider, vehicleName, vehicleVariant)) {
            return false
        }
        
        return true
    }
    
    private func validateMissionOutcome(time: Time, missionOutcome: Outcome) -> Bool {
        
        showValidationSteps ? print("Mission Outcome Section") : nil
        
        showValidationSteps ? print("\tValue: (\(missionOutcome.rawValue)) isNotEmpty: \(!missionOutcome.rawValue.isEmpty)") : nil
        if(missionOutcome.rawValue.isEmpty) {
            return false
        }
        
        if(time.getBool()) {
            
            showValidationSteps ? print("\tValue: (\(missionOutcome.rawValue)) hasOutcome: \(missionOutcome != .upcoming)") : nil
            if(missionOutcome == .upcoming) {
                return false
            }
        }
        
        else {
            showValidationSteps ? print("\tValue: (\(missionOutcome.rawValue)) isUpcoming: \(missionOutcome == .upcoming)") : nil
            if(missionOutcome != .upcoming) {
                return false
            }
        }
        
        return true
    }
    
    private func validateCrewedMission(crewedLaunch: String) -> Bool {
        
        showValidationSteps ? print("Crewed Mission Section") : nil
        
        showValidationSteps ? print("\tValue: (\(crewedLaunch)) isNotEmpty: \(!crewedLaunch.isEmpty), isBool: \(crewedLaunch.isBool)") : nil
        if(crewedLaunch.isEmpty && !crewedLaunch.isBool) {
            return false
        }
        
        return true
    }
    
    private func validateStaticFire(time: Time, staticFireGap: String) -> Bool {
        
        showValidationSteps ? print("Static Fire Section") : nil
        
        if(time.getBool()) {
            
            showValidationSteps ? print("\tValue: (\(staticFireGap)) isDigit: \(staticFireGap.isDigit)") : nil
            if(!staticFireGap.isDigit) {
                return false
            }
        }
        
        else {
            showValidationSteps ? print("\tValue: (\(staticFireGap)) isEmpty: \(staticFireGap.isEmpty)") : nil
            if(!staticFireGap.isEmpty) {
                return false
            }
        }
        
        return true
    }
    
    private func validateBoosterName(boosterNames: [String]) -> Bool {
        
        showValidationSteps ? print("Booster Name Section") : nil
        
        for booster in boosterNames {
            showValidationSteps ? print("\tValue: (\(booster)) isAlphaNumericDash: \(booster.isAlphaNumericDash)") : nil
            if(!booster.isAlphaNumericDash) {
                return false
            }
        }
        return true
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func hasLaunchSite(_ time: Time, _ key: String) -> Bool {
        return time.getBool() ? knownLaunchSite.keys.contains(key) : knownLaunchSite.keys.contains(key) || unknownLaunchSite.keys.contains(key)
    }
    
    func hasLaunchPad(_ time: Time, _ key: String, _ value: String) -> Bool {
        
        //Past Launches
        if(time.getBool()) {
            if let values = knownLaunchSite[key] {
                return values.contains(value)
            }
            return false
        }
        
        //Future Launches
        else {
            var pastBool: Bool = false
            if let values = knownLaunchSite[key] {
                pastBool = values.contains(value)
            }
            
            var futureBool: Bool = false
            if let values = unknownLaunchSite[key] {
                futureBool = values.contains(value)
            }
            
            return (pastBool || futureBool)
        }
    }
    
    func hasLaunchProvider(_ provider: String) -> Bool {
        return launchProviders.keys.contains(provider)
    }
    
    func hasVehicleName(_ provider: String, _ vehicle: String) -> Bool {
        
        if let providerData = launchProviders[provider], providerData[vehicle] != nil {
            return true
        }
        return false
    }
    
    func hasVehicleVariant(_ provider: String, _ vehicle: String, _ variant: String) -> Bool {
        
        if let providerData = launchProviders[provider], let vehicleData = providerData[vehicle] {
            return vehicleData.contains(variant)
        }
        return false
    }
}
