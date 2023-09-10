//
//  LaunchViewModel.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/14/23.
//

import Foundation
import Combine

class LaunchViewModel: ObservableObject {
    
    @Published var previousLaunches: [Launch] = []
    @Published var upcomingLaunches: [Launch] = []
    
    @Published var launch: Launch? = nil
    
    @Published var showFutureLaunches: Bool = true
    
    @Published var isInfoPresented: Bool = false
    @Published var isSettingsPresented: Bool = false
    @Published var isCalendarPresented: Bool = false
    @Published var isFavoritesPresented: Bool = false
    
    private var dataService = LaunchDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$upcomingLaunches
            .sink { [weak self] (upcomingLaunches) in
                self?.upcomingLaunches = upcomingLaunches
            }
            .store(in: &cancellables)
        dataService.$previousLaunches
            .sink { [weak self] (previousLaunches) in
                self?.previousLaunches = previousLaunches
            }
            .store(in: &cancellables)
    }
}
