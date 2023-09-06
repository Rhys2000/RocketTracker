//
//  LaunchSiteListView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/6/23.
//

import SwiftUI

struct LaunchSiteListView: View {
    
    let launchSiteList: [LaunchSite]
    
    var body: some View {
        List {
            ForEach(launchSiteList) { launchSite in
                LaunchSiteRowView(launchSite: launchSite)
                    .listRowBackground(Color.theme.primaryBackground)
                    .listRowSeparator(.hidden)
                    .shadow(color: Color.theme.accent.opacity(1), radius: 10)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct LaunchSiteListView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchSiteListView(launchSiteList: dev.launchSiteVM.allLaunchSites)
    }
}
