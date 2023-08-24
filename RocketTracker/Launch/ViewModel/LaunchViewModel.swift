//
//  LaunchViewModel.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/14/23.
//

import Foundation
import Combine

class LaunchViewModel: ObservableObject {
    
    @Published var pastLaunches: [Launch] = []
    @Published var futureLaunches: [Launch] = []
    
    private var dataService = LaunchDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$futureLaunches
            .sink { [weak self] (futureLaunches) in
                self?.futureLaunches = futureLaunches
            }
            .store(in: &cancellables)
        dataService.$pastLaunches
            .sink { [weak self] (pastLaunches) in
                self?.pastLaunches = pastLaunches
            }
            .store(in: &cancellables)
    }
}
