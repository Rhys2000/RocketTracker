//
//  LaunchView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/14/23.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject private var vm: LaunchViewModel
    
    @State private var showFutureLaunches: Bool = true
    @State private var isInfoPresented: Bool = false
    @State private var isSettingsPresented: Bool = false
    @State private var isCalendarPresented: Bool = false
    @State private var isFavoritesPresented: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.primaryBackground
                .ignoresSafeArea()
            
            VStack {
                headerBar
                
                SearchBarView(searchText: .constant(""))
                
                ScopeBarView(overlayBool: $showFutureLaunches)
                
                showFutureLaunches ? LaunchListView(list: vm.futureLaunches) : LaunchListView(list: vm.pastLaunches)
                
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
                .sheet(isPresented: $isInfoPresented, content: {
                    InfoView(showSheet: $isInfoPresented)
                })
                .onTapGesture {
                    isInfoPresented.toggle()
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
                .sheet(isPresented: $isSettingsPresented, content: {
                    SettingsView()
                })
                .onTapGesture {
                    isSettingsPresented.toggle()
                }
        }
        .padding(.horizontal)
    }
}
