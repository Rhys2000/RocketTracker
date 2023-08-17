//
//  LaunchViewModel.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/14/23.
//

import Foundation
import Combine

class LaunchViewModel: ObservableObject {
    
    @Published var allLaunches: [Launch] = []
    
    private var dataService = LaunchDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allLaunches
            .sink { [weak self] (returnedLaunches) in
                self?.allLaunches = returnedLaunches
            }
            .store(in: &cancellables)
    }
}
