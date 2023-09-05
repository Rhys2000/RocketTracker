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
    
    
    
    
    
    
}
