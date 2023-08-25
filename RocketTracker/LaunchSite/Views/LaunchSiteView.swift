//
//  LaunchSiteView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/14/23.
//

import SwiftUI

struct LaunchSiteView: View {
    
    @EnvironmentObject private var vm: LaunchSiteViewModel
    
    var body: some View {
        ZStack {
            Color.theme.primaryBackground
                .ignoresSafeArea()
            VStack {
                Text("Hello")
                    .foregroundColor(Color.purple)
                ForEach(vm.allLaunchSites) { launchSite in
                    Text("hello")
                        .foregroundColor(Color.theme.primaryText)
                }
            }
        }
    }
}

struct LaunchSiteView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchSiteView()
            .environmentObject(dev.launchSiteVM)
    }
}
