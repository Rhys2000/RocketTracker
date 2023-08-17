//
//  RocketTrackerApp.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/14/23.
//

import SwiftUI

@main
struct RocketTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                LaunchView()
                    .tabItem {
                        Label("Launches", systemImage: "car.circle")
                    }
                LaunchSiteView()
                    .tabItem {
                        Label("Launch Sites", systemImage: "map.circle.fill")
                    }
            }
        }
    }
}
