//
//  LaunchSiteViewModel.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/14/23.
//

import Foundation
import Combine

class LaunchSiteViewModel: ObservableObject {
    
    @Published var allLaunchSites: [LaunchSite] = []
    
    private var dataService = LaunchSiteDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allLaunchSites
            .sink { [weak self] (launchSites) in
                self?.allLaunchSites = launchSites
            }
            .store(in: &cancellables)
    }
}
