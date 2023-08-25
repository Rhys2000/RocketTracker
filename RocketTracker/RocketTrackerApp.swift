//
//  RocketTrackerApp.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/14/23.
//

import SwiftUI

@main
struct RocketTrackerApp: App {
    
    @StateObject var lvm = LaunchViewModel()
    @StateObject var lsvm = LaunchSiteViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                LaunchView()
                    .tabItem {
                        Label("Launches", systemImage: "car.circle")
                    }
                    .environmentObject(lvm)
                LaunchSiteView()
                    .tabItem {
                        Label("Launch Sites", systemImage: "map.circle.fill")
                    }
                    .environmentObject(lsvm)
            }
        }
    }
}
