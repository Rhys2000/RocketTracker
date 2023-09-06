//
//  Booster.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/3/23.
//

import Foundation

struct Booster: Identifiable {
    
    let id = UUID()
    var name: String = ""
    var method: RecoveryMethod = .notAvailable
    var location: String = ""
    var distance: String = ""
    var outcome: Outcome = .notAvailable
    var flightNumber: Int = 0
    
    func getNumberOfFlights() -> String {
        return "\(flightNumber.addNumberEnding()) launch for this booster"
    }
    
    func getDaysSinceLastFlight(launch: Launch) -> String {
        let fullLaunchList = LaunchDataService().allLaunches
        let currentLaunchIndex = fullLaunchList.firstIndex(where: { $0.missionName == launch.missionName })!
        
        let previousLaunchList = fullLaunchList[0..<currentLaunchIndex].reversed()
        let previousLaunchIndex = previousLaunchList.firstIndex(where: { $0.boosterData.contains(where: { $0.contains(name) }) })!
        let previousLaunchLiftOff = previousLaunchList[previousLaunchIndex].liftOffTime
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let timeDifference = (dateFormatter.date(from: launch.liftOffTime)! - dateFormatter.date(from: previousLaunchLiftOff)!) / 86400

        let numberFormatter = NumberFormatter()
        numberFormatter.usesSignificantDigits = true
        numberFormatter.maximumSignificantDigits = 4
        
        return "\(numberFormatter.string(from: NSNumber(value: timeDifference))!) days since last launch"
    }
    
    func formatRecoveryMethod(pastLaunch: Bool) -> String {
        switch method {
        case .expended:
            if(pastLaunch) {
                return "The booster was expended at the end of this launch"
            } else {
                return "The booster will be expended at the end of this launch"
            }
        case .droneship:
            if(pastLaunch) {
                return "The booster \(formatRecoveryOutcome()) aboard the droneship \(location) positioned \(distance) km downrange"
            } else {
                return "The booster will attempt to land aboard the droneship \(location) positioned \(distance) km downrange"
            }
        case .returnToLaunchSite:
            if(pastLaunch) {
                return "The booster \(formatRecoveryOutcome()) to the launch site \(distance) km downrange at \(location)"
            } else {
                return "The booster will attempt to return to launch site and land \(distance) km downrange at \(location)"
            }
        case .hoverslam:
            if(pastLaunch) {
                return "The booster \(formatRecoveryOutcome()) \(distance) km downrange in the \(location) ocean"
            } else {
                return "The booster will attempt to softly splash down \(distance) km downrange in the \(location) ocean"
            }
        default:
            print("I have an error \(name)-\(flightNumber)")
            return "Error"
        }
    }
    
    func formatRecoveryOutcome() -> String {
        if(method == .droneship) {
            switch outcome {
            case .success:
                return "successfully landed"
            case .failure:
                return "failed to land"
            default:
                print("I have an error \(name)-\(flightNumber)")
                return "Error"
            }
        } else if(method == .returnToLaunchSite) {
            switch outcome {
            case .success:
                return "successfully returned"
            case .failure:
                return "failed to return"
            default:
                print("I have an error \(name)-\(flightNumber)")
                return "Error"
            }
        } else {
            switch outcome {
            case .success:
                return "successfully splashed down"
            case .failure:
                return "failed to splash down"
            default:
                print("I have an error \(name)-\(flightNumber)")
                return "Error"
            }
        }
    }
    
    func getPreviousMissions(launch: Launch) -> String {
        let fullLaunchList = LaunchDataService().allLaunches
        let currentLaunchIndex = fullLaunchList.firstIndex(where: { $0.missionName == launch.missionName })!
        
        var returnedString = "This booster previously supported the "
        var previousMissions: [String] = []
        
        for launch in fullLaunchList[0..<currentLaunchIndex] {
            if(launch.boosterData.contains(where: { $0.contains(name)})) {
                previousMissions.append(launch.abbrMissionName.isEmpty ? launch.missionName : launch.abbrMissionName)
            }
        }
        
        for mission in previousMissions {
            if(mission == previousMissions.last) {
                returnedString += "and \(mission) mission"
            } else {
                returnedString += "\(mission), "
            }
        }
        
        if(previousMissions.count > 1) {
            returnedString += "s"
        }
        
        return returnedString
    }
}
