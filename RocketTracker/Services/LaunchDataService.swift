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
    private var showValidationSteps: Bool = true
    
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
            
            
            if(!cosparBool || !nameBool || !liftOffBool || !orbitBool || !launchSiteBool || !providerBool) {
                print("\(launchNumber): \(launch.id) -> \(cosparBool), \(nameBool), \(liftOffBool), \(orbitBool), \(launchSiteBool), \(providerBool)\n\n\n")
            }
        }
    }
    
    private func validateCosparCode(time: Time, cosparCode: String) -> Bool {
        
        var goodData: Bool = true
        
        showValidationSteps ? print("Cospar Code Section") : nil
        
        //Past Launches
        if(time.getBool()) {
            
            //Check to make sure that cosparCode is the right length
            showValidationSteps ? print("\tValue: (\(cosparCode)) -> Count: \(cosparCode.count), isNotEmpty: \(!cosparCode.isEmpty)") : nil
            if(cosparCode.count != 8 || cosparCode.isEmpty) {
                goodData = false
            }
            
            //Check to make sure the first 4 characters in cosparCode are made of numbers (0-9)
            var currentString = cosparCode.subString(from: 0, to: 4)
            showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit)") : nil
            if(!currentString.isDigit) {
                goodData = false
            }
            
            //Change. Add additional check that cosparCode is equal to year within liftOffTime
            
            //Check to make sure the fifth character in cosparCode is equal to "-"
            currentString = cosparCode.subString(from: 4, to: 5)
            showValidationSteps ? print("\tValue: (\(currentString)) -> isEqual: \(currentString.isEqual("-"))") : nil
            if(!currentString.isEqual("-")) {
                goodData = false
            }
            
            //Check to make sure the sixth character in cosparCode is either a number (0-9) and the sixth character is not an uppercase english letter
            currentString = cosparCode.subString(from: 5, to: 6)
            showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit), isCapitalLetter: \(currentString.isCapitalLetter)") : nil
            if(!currentString.isDigit && !currentString.isCapitalLetter) {
                goodData = false
            }
            
            //Check to make sure the last two characters in cosparCode are made of numbers (0-9)
            currentString = cosparCode.subString(from: 6, to: 8)
            showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit)") : nil
            if(!currentString.isDigit) {
                goodData = false
            }
            
            return goodData
        }
        
        //Future Launches
        else {
            
            //Check to make sure that cosparCode is empty (blank string)
            showValidationSteps ? print("\tValue: (\(cosparCode)) -> isEmpty: \(cosparCode.isEmpty)") : nil
            if(!cosparCode.isEmpty) {
                goodData = false
            }

            return goodData
        }
    }
    
    private func validateMissionNames(missionName: String, altMissionName: String, abbrMissionName: String) -> Bool {
        
        var goodData: Bool = true
        
        showValidationSteps ? print("Mission Name Section") : nil
        
        //Check to make sure that there is a value inside of missionName
        showValidationSteps ? print("\tValue: (\(missionName)) -> isNotEmpty: \(!missionName.isEmpty)") : nil
        if(missionName.isEmpty) {
            goodData = false
        }
        
        //Check to make sure that if there is a value inside of abbrevMissionName there is also one inside of missionName
        showValidationSteps ? print("\tValue: (\(abbrMissionName)) -> isNotEmpty: \(!abbrMissionName.isEmpty), so (missionName) isNotEmpty: \(!missionName.isEmpty)") : nil
        if(missionName.isEmpty && !abbrMissionName.isEmpty) {
            goodData = false
        }
        
        //Check to make sure that if there is a value inside of altMissionName there is also one inside of missionName
        showValidationSteps ? print("\tValue: (\(altMissionName)) -> isNotEmpty: \(!altMissionName.isEmpty), so (missionName) isNotEmpty: \(!missionName.isEmpty)") : nil
        if(missionName.isEmpty && !altMissionName.isEmpty) {
            goodData = false
        }
        
        return goodData
    }
    
    private func validateLiftOffTime(liftOffTime: String) -> Bool {
        
        var goodData: Bool = true
        
        showValidationSteps ? print("Lift Off Time Section") : nil
        
        //Check to make sure that liftOffTime is the right length and is not an empty string
        showValidationSteps ? print("\tValue: (\(liftOffTime)) -> Count: \(liftOffTime.count), isNotEmpty: \(!liftOffTime.isEmpty)") : nil
        if(liftOffTime.count != 24 || liftOffTime.isEmpty) {
            goodData = false
        }
        
        //Check to make sure that the first 4 characters in liftOffTime are made of digits (0-9)
        var currentString = liftOffTime.subString(from: 0, to: 4)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit), isBetween: \(currentString.isBetween(2010, 2028))") : nil
        if(!currentString.isDigit && !currentString.isBetween(2010, 2028)) {
            goodData = false
        }
        
        currentString = liftOffTime.subString(from: 4, to: 5)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isEqual: \(currentString.isEqual("-"))") : nil
        if(!currentString.isEqual("-")) {
            goodData = false
        }
        
        currentString = liftOffTime.subString(from: 5, to: 7)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit), isBetween: \(currentString.isBetween(1, 12))") : nil
        if(!currentString.isDigit && !currentString.isBetween(1, 12)) {
            goodData = false
        }
        
        currentString = liftOffTime.subString(from: 7, to: 8)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isEqual: \(currentString.isEqual("-"))") : nil
        if(!currentString.isEqual("-")) {
            goodData = false
        }
        
        currentString = liftOffTime.subString(from: 8, to: 10)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit), isBetween: \(currentString.isBetween(1, 31))") : nil
        if(!currentString.isDigit && !currentString.isBetween(1, 31)) {
            goodData = false
        }
        
        currentString = liftOffTime.subString(from: 10, to: 11)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isCapitalLetter: \(currentString.isCapitalLetter)") : nil
        if(!currentString.isCapitalLetter) {
            goodData = false
        }
        
        currentString = liftOffTime.subString(from: 11, to: 13)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit), isBetween: \(currentString.isBetween(0, 24))") : nil
        if(!currentString.isDigit && !currentString.isBetween(0, 24)) {
            goodData = false
        }
        
        currentString = liftOffTime.subString(from: 13, to: 14)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isEqual: \(currentString.isEqual(":"))") : nil
        if(!currentString.isEqual(":")) {
            goodData = false
        }
        
        currentString = liftOffTime.subString(from: 14, to: 16)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit), isBetween: \(currentString.isBetween(0, 59))") : nil
        if(!currentString.isDigit && !currentString.isBetween(0, 59)) {
            goodData = false
        }
        
        currentString = liftOffTime.subString(from: 16, to: 17)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isEqual: \(currentString.isEqual(":"))") : nil
        if(!currentString.isEqual(":")) {
            goodData = false
        }
        
        currentString = liftOffTime.subString(from: 17, to: 19)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit), isBetween: \(currentString.isBetween(0, 59))") : nil
        if(!currentString.isDigit && !currentString.isBetween(0, 59)) {
            goodData = false
        }
        
        currentString = liftOffTime.subString(from: 19, to: 20)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isEqual: \(currentString.isEqual("+"))") : nil
        if(!currentString.isEqual("+")) {
            goodData = false
        }
        
        currentString = liftOffTime.subString(from: 20, to: 24)
        showValidationSteps ? print("\tValue: (\(currentString)) -> isDigit: \(currentString.isDigit), isEqual: \(currentString.isEqual("0000"))") : nil
        if(!currentString.isDigit && currentString.isEqual("0000")) {
            goodData = false
        }
        
        return goodData

    }
    
    private func validateOrbitDestination(time: Time, orbitDestination: OrbitDestination) -> Bool {
        
        var goodData = true
        
        showValidationSteps ? print("Orbit Destination Section") : nil
        
        showValidationSteps ? print("\tValue: (\(orbitDestination.rawValue)) isNotEmpty: \(!orbitDestination.rawValue.isEmpty)") : nil
        if(orbitDestination.rawValue.isEmpty) {
            goodData = false
        }
        
        if(time.getBool()) {
            
            showValidationSteps ? print("\tValue: (\(orbitDestination.rawValue)) isAvailable: \(orbitDestination != .notAvailable)") : nil
            if(orbitDestination == .notAvailable) {
                goodData = false
            }
        }
        
        return goodData
    }
    
    private func validateLaunchSite(time: Time, launchSite: String, launchSitePad: String) -> Bool {
        
        var goodData: Bool = true
        
        showValidationSteps ? print("Launch Site Section") : nil
        
        if(time.getBool()) {
            showValidationSteps ? print("\tValue: (\(launchSite)) isNotEmpty: \(!launchSite.isEmpty), hasLaunchSite: \(hasLaunchSite(time, launchSite))") : nil
            if(launchSite.isEmpty && !hasLaunchSite(time, launchSite)) {
                goodData = false
            }
            
            showValidationSteps ? print("\tValue: (\(launchSitePad)) isNotEmpty: \(!launchSitePad.isEmpty), hasLaunchPad: \(hasLaunchPad(time, launchSite, launchSitePad))") : nil
            if(launchSitePad.isEmpty && !hasLaunchPad(time, launchSite, launchSitePad)) {
                goodData = false
            }
        }
        
        else {
            showValidationSteps ? print("\tValue: (\(launchSite)) isNotEmpty: \(!launchSite.isEmpty), hasLaunchSite: \(hasLaunchSite(time, launchSite))") : nil
            if(launchSite.isEmpty && !hasLaunchSite(time, launchSite)) {
                goodData = false
            }
        }
            
        
        return goodData
    }
    
    private func validateLaunchVehicleAndProvider(launchProvider: String, vehicleName: String, vehicleVariant: String) -> Bool {
        
        var goodData: Bool = true
        
        showValidationSteps ? print("Launch Provider and Vehicle Section") : nil
        
        showValidationSteps ? print("\tValue: (\(launchProvider)) isNotEmpty: \(!launchProvider.isEmpty), hasLaunchProvider: \(hasLaunchProvider(launchProvider))") : nil
        if(!launchProvider.isEmpty && !hasLaunchProvider(launchProvider)) {
            goodData = false
        }
        
        showValidationSteps ? print("\tValue: (\(vehicleName)) isNotEmpty: \(!vehicleName.isEmpty), hasVehicleName: \(hasVehicleName(launchProvider, vehicleName))") : nil
        if(!launchProvider.isEmpty && !hasVehicleName(launchProvider, vehicleName)) {
            goodData = false
        }
        
        showValidationSteps ? print("\tValue: (\(vehicleVariant)) hasVehicleVariant: \(hasVehicleVariant(launchProvider, vehicleName, vehicleVariant))") : nil
        if(!hasVehicleVariant(launchProvider, vehicleName, vehicleVariant)) {
            goodData = false
        }
        
        return goodData
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
