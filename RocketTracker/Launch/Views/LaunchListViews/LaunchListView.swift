//
//  LaunchListView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/25/23.
//

import SwiftUI

struct LaunchListView: View {
    
    let list: [Launch]
    
    var body: some View {
        List {
            ForEach(list) { launch in
                LaunchRowView(launch: launch)
                    .listRowBackground(Color.theme.primaryBackground)
                    .listRowSeparator(.hidden)
                    .shadow(color: Color.theme.accent.opacity(1), radius: 10)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct LaunchListView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchListView(list: dev.launchVM.futureLaunches)
    }
}
