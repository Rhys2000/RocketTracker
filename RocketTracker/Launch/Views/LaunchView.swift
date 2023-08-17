//
//  LaunchView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/14/23.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject private var lvm: LaunchViewModel
    
    var body: some View {
        ZStack {
            Color.theme.primaryBackground
                .ignoresSafeArea()
            VStack {
                List {
                    ForEach(lvm.allLaunches) { launch in
                        LaunchRowView(launch: launch)
                            .listRowBackground(Color.theme.primaryBackground)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(PlainListStyle())
                Spacer(minLength: 0)
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .environmentObject(dev.launchVM)
    }
}
