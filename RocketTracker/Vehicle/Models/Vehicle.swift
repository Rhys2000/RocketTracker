//
//  Vehicle.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/8/23.
//

import Foundation

//{
//    "vehicleName" : "",
//    "description" : [""],
//    "vehicleVariants" :
//    [
//        {
//            "variantName" : "",
//            "altVariantName" : "",
//            "vehicleHeight" : "",
//            "vehicleDiameter" : "",
//            "fairingHeight" : "",
//            "fairingDiameter" : "",
//            "manufacturer" : "",
//            "numberOfStages" : "",
//            "strapOnBoosters" : "",
//            "priceTag" : "",
//            "thrustAtLiftOff" : "",
//            "status" : "",
//        },
//    ]
//},

struct Vehicle: Identifiable, Codable {
    let vehicleName: String
    let description: [String]
    let vehicleVariants: [VehicleVariant]
    
    var id: String { vehicleName }
    
    var missionsFlown: Int {
        var temp: Int = 0
        for launch in LaunchDataService().previousLaunches {
            if(launch.vehicleName == vehicleName) {
                temp += 1
            }
        }
        return temp
    }
    
    var successfulMissions: Int {
        var temp: Int = 0
        for launch in LaunchDataService().previousLaunches {
            if(launch.vehicleName == vehicleName && launch.missionOutcome == .success) {
                temp += 1
            }
        }
        return temp
    }
    
    var partiallySuccessfulMissions: Int {
        var temp: Int = 0
        for launch in LaunchDataService().previousLaunches {
            if(launch.vehicleName == vehicleName && launch.missionOutcome == .partialSuccess) {
                temp += 1
            }
        }
        return temp
    }
    
    var failedMissions: Int {
        var temp: Int = 0
        for launch in LaunchDataService().previousLaunches {
            if(launch.vehicleName == vehicleName && (launch.missionOutcome == .failure || launch.missionOutcome == .explosion)) {
                temp += 1
            }
        }
        return temp
    }
    
    var successRate: Double {
        return ((Double(successfulMissions) + Double(Double(partiallySuccessfulMissions) * 0.5)) / Double(missionsFlown)) * 100
    }
    
    var successStreak: Int {
        var temp: Int = 0
        for launch in LaunchDataService().previousLaunches {
            if(launch.vehicleName == vehicleName && launch.missionOutcome == .success) {
                temp += 1
            }
        }
        return temp
    }
}
