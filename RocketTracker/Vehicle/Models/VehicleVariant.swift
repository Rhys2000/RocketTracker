//
//  VehicleVariant.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/8/23.
//

import Foundation

struct VehicleVariant: Identifiable, Codable {
    var id = UUID()
    let variantName: String
    let height: String
    let fairingHeight: String
    let fairingDiameter: String
    let manufacturer: String
    let numberOfStages: String
    let strapOnBoosters: String
    let priceTag: String
    let thrustAtLiftOff: String
    let status: OperationalStatus
}
