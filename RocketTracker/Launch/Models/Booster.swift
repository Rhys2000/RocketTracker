//
//  Booster.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/3/23.
//

import Foundation

struct Booster {
    var name: String = ""
    var method: RecoveryMethod = .notAvailable
    var location: String = ""
    var distance: String = ""
    var outcome: Outcome = .notAvailable
    var flightNumber: String = ""
}
