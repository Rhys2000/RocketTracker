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
            .sink { [weak self] (futureLaunches) in
                self?.futureLaunches = futureLaunches
            }
            .store(in: &cancellables)
        dataService.$previousLaunches
            .sink { [weak self] (pastLaunches) in
                self?.pastLaunches = pastLaunches
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
