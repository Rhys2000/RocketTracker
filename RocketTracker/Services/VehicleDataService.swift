//
//  VehicleDataService.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/8/23.
//

import Foundation

class VehicleDataService {
    @Published var allVehicles: [Vehicle] = []
    
    init() {
        loadVehicles()
    }
    
    private func loadVehicles() {
        if let fileLocation = Bundle.main.url(forResource: "vehicle", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                self.allVehicles = try jsonDecoder.decode([Vehicle].self, from: data)
            } catch {
                print(error)
            }
        }
    }
}
