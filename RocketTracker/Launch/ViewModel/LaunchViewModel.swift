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
    @Published var launchSite: LaunchSite? = nil
    @Published var launchPad: LaunchPad? = nil
    
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
    
    func getLaunchSite(location: String) {
        
        let service = LaunchSiteDataService()
        launchSite = service.allLaunchSites.first(where: {$0.shortName == location})
        
    }
    
    func getLaunchPad(pad: String) {
        launchPad = (launchSite?.launchPads.first(where: {$0.shortName == pad}))
    }
}
