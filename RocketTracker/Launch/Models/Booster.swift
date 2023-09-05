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
                return "The booster was expended at the end of this mission"
            } else {
                return "The booster will be expended at the end of this mission"
            }
        case .droneship:
            let tense = pastLaunch ? "\(formatRecoveryOutcome())" : "will attempt to land"
            return "The booster \(tense) aboard the droneship \(location) positioned \(distance) km downrange"
        case .returnToLaunchSite:
            let tense = pastLaunch ? "\(formatRecoveryOutcome())" : "will attempt to"
            return "The booster \(tense) return to launch site"
        case .hoverslam:
            let tense = pastLaunch ? "" : ""
            return "The booster"
        default:
            print("I have an error \(name)-\(flightNumber)")
            return "Error"
        }
    }
    
    
}
