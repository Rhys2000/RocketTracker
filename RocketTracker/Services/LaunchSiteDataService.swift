//
//  LaunchSiteDataService.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/25/23.
//

import Foundation

class LaunchSiteDataService {
    
    @Published var allLaunchSites: [LaunchSite] = []
    
    init() {
        loadLaunchSites()
    }
    
    private func loadLaunchSites() {
        if let fileLocation = Bundle.main.url(forResource: "launchsite", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                self.allLaunchSites = try jsonDecoder.decode([LaunchSite].self, from: data)
            } catch {
                print(error)
            }
        }
    }
}
