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
            Image("Falcon9Block5")
                .resizable()
                .frame(width: 130) //maxHeight: textHeight)
                .frame(maxHeight: textHeight)
                .cornerRadius(15, corners: [.topLeft, .bottomLeft])
            VStack(alignment: .leading) {
                Text(launch.abbreviatedMissionName!.isEmpty ? launch.missionName : launch.abbreviatedMissionName!)
                    .bold()
                    .font(.title2)
                    .frame(minHeight: 25)
                Text(launch.launchProvider.rawValue)
                    .frame(minHeight: 0)
                Text(launch.vehicleName + " " + launch.vehicleVariant)
                    .frame(minHeight: 0)
                Text(launch.launchPad + ", " + launch.launchSite)
                    .frame(minHeight: 0)
                Text((launch.boosterRecoveryMethod[0]?.rawValue)!)
                    .frame(minHeight: 0)
                Text(launch.liftOffTime + " e ")
            }
            .font(.headline)
            .background(Color.orange)
            .padding(.leading)
            .cornerRadius(15, corners: [.topRight, .bottomRight])
            .overlay(
                GeometryReader(content: { geometry in
                    Color.clear
                            .onAppear(perform: {
                                self.textHeight = geometry.frame(in: .local).size.height
                            })
                    })
                )
        }
        .frame(width: .infinity)
        .background(Color.green)
    }
}

struct LaunchRowView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchRowView(launch: dev.launch)
    }
}
