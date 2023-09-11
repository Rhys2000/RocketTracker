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
    let altVariantName: String
    let vehicleHeight: Double
    let vehicleDiameter: Double
    let fairingHeight: Double
    let fairingDiameter: Double
    let manufacturer: String
    let numberOfStages: Int
    let strapOnBoosters: Int
    let priceTag: String
    let thrustAtLiftOff: Int //in kN
    let status: OperationalStatus
}
