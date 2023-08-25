//
//  LaunchRowView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/15/23.
//

import SwiftUI

struct LaunchRowView: View {
    
    let launch: Launch
    
    @State var textHeight = CGFloat.zero
    
    var body: some View {
        HStack(spacing: 0) {
            imageView
            
            VStack(alignment: .leading) {
                missionText
                providerText
                vehicleText
                locationText
                recoveryText
                liftOffTimeText
            }
            //.background(Color.orange)
            .padding(.leading, 8)
            .overlay(
                GeometryReader(content: { geometry in
                    Color.clear
                            .onAppear(perform: {
                                self.textHeight = geometry.frame(in: .local).size.height
                            })
                    })
                )
            Spacer()
        }
        .background(Color.theme.secondaryBackground)
        .cornerRadius(15, corners: [.allCorners])
    }
}

struct LaunchRowView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchRowView(launch: dev.launch)
    }
}

extension LaunchRowView {
    private var imageView: some View {
        Image("Falcon9Block5")
            .resizable()
            .frame(width: 130) //maxHeight: textHeight)
            .frame(maxHeight: textHeight)
            .cornerRadius(15, corners: [.topLeft, .bottomLeft])
    }
    
    private var missionText: some View {
        Text(launch.abbrMissionName.isEmpty ? launch.missionName : launch.abbrMissionName)
            .bold()
            .font(.title2)
            .frame(minHeight: 25)
            .foregroundColor(Color.theme.primaryText)
            .padding(.top, 5)
    }
    
    private var providerText: some View {
        Text(launch.launchProvider)
            .frame(minHeight: 0)
            .font(.headline)
            .foregroundColor(Color.theme.secondaryText)
    }
    
    private var vehicleText: some View {
        Text(launch.vehicleName + " " + launch.vehicleVariant)
            .frame(minHeight: 0)
            .font(.headline)
            .foregroundColor(Color.theme.secondaryText)
    }
    
    private var locationText: some View {
        Text(launch.launchSitePad + ", " + launch.launchSite)
            .frame(minHeight: 0)
            .font(.headline)
            .foregroundColor(Color.theme.secondaryText)
    }
    
    private var recoveryText: some View {
        Text(launch.boosterRecoveryMethod[0].rawValue)
            .frame(minHeight: 0)
            .font(.headline)
            .foregroundColor(Color.theme.secondaryText)
    }
    
    private var liftOffTimeText: some View {
        Text(launch.liftOffTime.stringAsADate() + "  ")
            .font(.headline)
            .foregroundColor(Color.theme.primaryText)
            .padding(.bottom, 5)
    }
}
