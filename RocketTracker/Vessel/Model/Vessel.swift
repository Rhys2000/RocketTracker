//
//  Vessel.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/17/23.
//

import Foundation

enum VesselRole: String, Codable {
    case asds = "ASDS" //Autonomous Spaceport Drone Ship
    case brv = "BRV" //Booster Recovery Vessel
    case bstv = "BSTV" //Booster Splashdown Telemetry Vessel
    case drv = "DRV" //Dragon Recovery Vessel
    case dsv = "DSV" //Droneship Support Vessel
    case fcv = "FCV" //Fairing Catching Vessel
    case frv = "FRV" //Fairing Recovery Vessel
    case tug = "TUG" //Tugboat
    case notAvailable = "NA"
}
