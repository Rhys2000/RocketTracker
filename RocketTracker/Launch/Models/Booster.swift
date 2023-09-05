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
    
    
    
    
}
