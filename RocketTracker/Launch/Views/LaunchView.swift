//
//  LaunchView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/14/23.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject private var vm: LaunchViewModel
    
    @State private var showFutureLaunches: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.primaryBackground
                .ignoresSafeArea()
            
            VStack {
                headerBar
                
                SearchBarView(searchText: .constant(""))
                
                ScopeBarView()
                
                !showFutureLaunches ? LaunchListView(list: vm.futureLaunches) : LaunchListView(list: vm.pastLaunches)
                
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

extension LaunchView {
    
    private var headerBar: some View {
        HStack {
            CircleButtonView(iconName: "info")
            Spacer()
            Text("Launches")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.primaryText)
            Spacer()
            CircleButtonView(iconName: "gear")
        }
        .padding(.horizontal)
    }
}
