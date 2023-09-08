//
//  Vehicle.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/8/23.
//

import Foundation

struct Vehicle: Identifiable, Codable {
    let vehicleName: String
    
    var id: String { vehicleName }
}
