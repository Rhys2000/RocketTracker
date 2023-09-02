//
//  LaunchView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/14/23.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject private var vm: LaunchViewModel
    
    var body: some View {
        ZStack {
            Color.theme.primaryBackground
                .ignoresSafeArea()
            
            VStack {
                headerBar//
                
                SearchBarView(searchText: .constant(""))
                
                ScopeBarView(overlayBool: $vm.showFutureLaunches)
                
                vm.showFutureLaunches ? LaunchListView(list: vm.futureLaunches) : LaunchListView(list: vm.pastLaunches)
                
                Spacer(minLength: 0)
            }
            .sheet(item: $vm.currentLaunch, onDismiss: nil) { launch in
                LaunchDetailView(launch: launch)
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
                .sheet(isPresented: $vm.isInfoPresented) {
                    InfoView()
                }
                .onTapGesture {
                    vm.isInfoPresented.toggle()
                }
            
            CircleButtonView(iconName: "calendar")
            Spacer()
            Text("Launches")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.primaryText)
            Spacer()
            CircleButtonView(iconName: "star.fill")
            CircleButtonView(iconName: "gear")
                .sheet(isPresented: $vm.isSettingsPresented) {
                    SettingsView()
                }
                .onTapGesture {
                    vm.isSettingsPresented.toggle()
                }
        }
        .padding(.horizontal)
    }
}
