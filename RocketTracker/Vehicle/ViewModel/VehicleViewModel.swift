//
//  VehicleViewModel.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/8/23.
//

import Foundation
import Combine

class VehicleViewModel: ObservableObject {
    
    @Published var allVehicles: [Vehicle] = []
    
    @Published var vehicle: Vehicle? = nil
    
    private var dataService = VehicleDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$allVehicles
            .sink { [weak self] (vehicles) in
                self?.allVehicles = vehicles
            }
            .store(in: &cancellables)
    }
    
}
