//
//  LaunchDataService.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/17/23.
//

import Foundation
import Combine

class LaunchDataService {
    
    @Published var allLaunches: [Launch] = []
    
    init() {
        loadLaunches()
    }
    
    private func loadLaunches() {
        if let fileLocation = Bundle.main.url(forResource: "spacex", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                self.allLaunches = try jsonDecoder.decode([Launch].self, from: data)
            } catch {
                print(error)
            }
        }
    }
}
