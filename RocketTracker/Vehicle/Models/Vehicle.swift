//
//  Vehicle.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/8/23.
//

import Foundation

struct Vehicle: Identifiable, Codable {
    let vehicleName: String
    let description: [String]
    let vehicleVariants: [VehicleVariant]
    
    var id: String { vehicleName }
    
    var missionsFlown: Double {
        var temp: Double = 0
        for launch in LaunchDataService().previousLaunches {
            if(launch.vehicleName == vehicleName) {
                temp += 1
            }
        }
        return temp
    }
    
    var successfulMissions: Double {
        var temp: Double = 0
        for launch in LaunchDataService().previousLaunches {
            if(launch.vehicleName == vehicleName && launch.missionOutcome == .success) {
                temp += 1
            }
        }
        return temp
    }
    
    var partiallySuccessfulMissions: Double {
        var temp: Double = 0
        for launch in LaunchDataService().previousLaunches {
            if(launch.vehicleName == vehicleName && launch.missionOutcome == .partialSuccess) {
                temp += 1
            }
        }
        return temp
    }
    
    var failedMissions: Double {
        var temp: Double = 0
        for launch in LaunchDataService().previousLaunches {
            if(launch.vehicleName == vehicleName && (launch.missionOutcome == .failure || launch.missionOutcome == .explosion)) {
                temp += 1
            }
        }
        return temp
    }
    
    var successRate: Double {
        return (successfulMissions + (partiallySuccessfulMissions * 0.5)) / missionsFlown
    }
    
    var successStreak: Double {
        var temp: Double = 0
        for launch in LaunchDataService().previousLaunches {
            if(launch.vehicleName == vehicleName && launch.missionOutcome == .success) {
                temp += 1
            }
        }
        print(temp)
        return temp
    }
}
