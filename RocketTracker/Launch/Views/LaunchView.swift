//
//  LaunchView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/14/23.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject private var lvm: LaunchViewModel
    @State private var showFutureLaunches: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.primaryBackground
                .ignoresSafeArea()
            VStack {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: 10)
                listBar
                    .padding(.horizontal)
                if(!showFutureLaunches) {
                    futureLaunchList
                        .transition(.move(edge: .leading))
                } else {
                    pastLaunchList
                        .transition(.move(edge: .trailing))
                }
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
    private var listBar: some View {
        HStack {
            Text("Future")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.primaryText)
                .onTapGesture {
                    showFutureLaunches.toggle()
                }
                .frame(width: UIScreen.main.bounds.width / 2, height: 40)
            Spacer()
            Rectangle()
                .frame(width: 1, height: 40)
                .background(Color.black)
            Spacer()
            Text("Past")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.primaryText)
                .onTapGesture {
                    showFutureLaunches.toggle()
                }
                .frame(width: UIScreen.main.bounds.width / 2)
        }
        .padding(.horizontal)
        .background(Color.theme.primaryBackground)
        .shadow(radius: 10)
    }
    
    private var pastLaunchList: some View {
        List {
            ForEach(lvm.pastLaunches) { launch in
                LaunchRowView(launch: launch)
                    .listRowBackground(Color.theme.primaryBackground)
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var futureLaunchList: some View {
        List {
            ForEach(lvm.futureLaunches) { launch in
                LaunchRowView(launch: launch)
                    .listRowBackground(Color.theme.primaryBackground)
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(PlainListStyle())
    }
}
