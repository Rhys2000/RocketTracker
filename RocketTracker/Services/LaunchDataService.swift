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
        
        //Change this to print validation steps to the console. True = Output to console, false = Output only if Errors
        showValidationSteps = false
        
        for (launch, launchNumber) in zip(allLaunches, 0..<allLaunches.count) {
            
            showValidationSteps ? print("*--- Validating Launch: \(launch.missionName) ---*\n") : nil
            
            let cosparBool = validateCosparCode(time: launch.time, cosparCode: launch.cosparCode)
            let nameBool = validateMissionNames(missionName: launch.missionName, altMissionName: launch.altMissionName, abbrMissionName: launch.abbrMissionName)
            
            if(!cosparBool || !nameBool) {
                print("\(launchNumber): \(launch.id)\n\n\n")
            }
        }
        
    }
    
    private func validateCosparCode(time: Time, cosparCode: String) -> Bool {
        
        var goodData: Bool = true
        
        showValidationSteps ? print("Cospar Code Section") : nil
        
        //Past Launches
        if(time.getBool()) {
            
            //Check to make sure that cosparCode is the right length
            showValidationSteps ? print("\tValue: (\(cosparCode)) -> Count: \(cosparCode.count), isEmpty: \(cosparCode.isEmpty)") : nil
            if(cosparCode.count != 8 || cosparCode.isEmpty) {
                goodData = false
            }
            
            //Check to make sure the first 4 characters in cosparCode are made of numbers (0-9)
            var currentString = cosparCode.subString(from: 0, to: 4)
            showValidationSteps ? print("\tValue: (\(currentString)) -> isNumber: \(currentString.isDigit)") : nil
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
            showValidationSteps ? print("\tValue: (\(currentString)) -> isNumber: \(currentString.isDigit), isCapitalLetter: \(currentString.isCapitalLetter)") : nil
            if(!currentString.isDigit && !currentString.isCapitalLetter) {
                goodData = false
            }
            
            //Check to make sure the last two characters in cosparCode are made of numbers (0-9)
            currentString = cosparCode.subString(from: 6, to: 8)
            showValidationSteps ? print("\tValue: (\(currentString)) -> isNumber: \(currentString.isDigit)") : nil
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
        showValidationSteps ? print("\tValue: (\(missionName)) -> isEmpty: \(missionName.isEmpty)") : nil
        if(missionName.isEmpty) {
            goodData = false
        }
        
        //Check to make sure that if there is a value inside of abbrevMissionName there is also one inside of missionName
        showValidationSteps ? print("\tValue: (\(abbrMissionName)) -> isNotEmpty: \(abbrMissionName.isEmpty), isEmpty: \(missionName.isEmpty)") : nil
        if(missionName.isEmpty && !abbrMissionName.isEmpty) {
            goodData = false
        }
        
        //Check to make sure that if there is a value inside of altMissionName there is also one inside of missionName
        showValidationSteps ? print("\tValue: (\(altMissionName)) -> isNotEmpty: \(altMissionName.isEmpty), isEmpty: \(missionName.isEmpty)") : nil
        if(missionName.isEmpty && !altMissionName.isEmpty) {
            goodData = false
        }
        
        return goodData
    }
    
//    private func validateLiftOffTime(liftOffTime: String) -> Bool {
//
//    }
}
