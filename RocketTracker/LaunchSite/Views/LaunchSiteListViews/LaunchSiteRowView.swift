//
//  LaunchSiteRowView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/6/23.
//

import SwiftUI

struct LaunchSiteRowView: View {
    
    let launchSite: LaunchSite
    
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

struct LaunchSiteRowView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchSiteRowView(launchSite: dev.launchSite)
    }
}

extension LaunchSiteRowView {
    
    private var imageView: some View {
        Image(launchSite.shortName.replacingOccurrences(of: " ", with: ""))
            .resizable()
            .frame(width: .infinity, height: 200)
    }
    
    private var firstRow: some View {
        HStack(alignment: .top) {
            Text(launchSite.fullName)
                .font(.headline)
                .bold()
                .foregroundColor(Color.theme.primaryText)
            Spacer()
            Text(launchSite.owner + " ")
                .font(.headline)
                .bold()
                .foregroundColor(Color.theme.secondaryText)
        }
        .padding(.top, 4)
        .padding(.horizontal, 8)
    }
    
    private var secondRow: some View {
        HStack {
            Text("\(launchSite.territory), \(launchSite.country) \(launchSite.getCountryFlag())")
                .font(.subheadline)
                .bold()
                .foregroundColor(Color.theme.secondaryText)
            Spacer()
            Text(" \(launchSite.status.rawValue) ")
                .font(.subheadline)
                .bold()
                .foregroundColor(Color.white)
                .background(launchSite.status.getBackgroundColor())
                .cornerRadius(5, corners: .allCorners)
        }
        .padding(.bottom, 8)
        .padding(.horizontal, 8)
    }
}
