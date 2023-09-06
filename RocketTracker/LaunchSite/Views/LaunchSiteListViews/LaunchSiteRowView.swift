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
        .padding(.bottom, 8)
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
        Image(launchSite.shortName)
            .resizable()
            .frame(width: .infinity, height: 250)
    }
    
    private var firstRow: some View {
        HStack {
            Text("Name:")
            Text(launchSite.fullName)
        }
        .padding(.horizontal, 8)
    }
    
    private var secondRow: some View {
        HStack {
            Text("Location:")
            Text("\(launchSite.territory), \(launchSite.country)")
        }
        .padding(.horizontal, 8)
    }
}
