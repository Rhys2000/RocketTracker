//
//  LaunchPadRowView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/7/23.
//

import SwiftUI

struct LaunchPadRowView: View {
    
    let launchPad: LaunchPad
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            imageView
            firstRow
            secondRow
        }
        .background(Color.theme.secondaryBackground)
        .cornerRadius(15, corners: .allCorners)
    }
}

struct LaunchPadRowView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchPadRowView(launchPad: dev.launchSite.launchPads[0])
    }
}

extension LaunchPadRowView {
    
    private var imageView: some View {
        Image(launchPad.shortName)
            .resizable()
            .frame(width: .infinity, height: 200)
    }
        
    private var firstRow: some View {
        HStack {
            Text(launchPad.fullName)
                .font(.headline)
                .bold()
                .foregroundColor(Color.theme.primaryText)
            Spacer()
            Text(launchPad.operatorName)
                .font(.headline)
                .bold()
                .foregroundColor(Color.theme.secondaryText)
        }
        .padding(.top, 6)
        .padding(.horizontal, 8)
    }
    
    private var secondRow: some View {
        HStack {
            Text(launchPad.convertToNWCoordinates(latitude: launchPad.latitude, longitude: launchPad.longitude))
                .font(.subheadline)
                .bold()
                .foregroundColor(Color.theme.secondaryText)
            Spacer()
            Text(" \(launchPad.status.rawValue) ")
                .font(.subheadline)
                .bold()
                .foregroundColor(Color.white)
                .background(launchPad.status.getBackgroundColor())
                .cornerRadius(5, corners: .allCorners)
        }
        .padding(.bottom, 8)
        .padding(.horizontal, 8)
    }
}
