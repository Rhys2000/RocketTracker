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
    
    @Published var currentLaunch: Launch? = nil
    @Published var currentLocation: LaunchSite? = nil
    @Published var currentPad: LaunchPad? = nil
    
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
    
    func getLocation(location: String) {
        
        let service = LaunchSiteDataService()
        currentLocation = service.allLaunchSites.first(where: {$0.shortName == location})
        
    }
    
    func getPad(pad: String) {
        currentPad = (currentLocation?.launchPads.first(where: {$0.shortName == pad}))
    }
}
