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
        VStack {
            
        }
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
                .font(.subheadline)
                .bold()
            Spacer()
            Text(launchSite.status.rawValue)
                .font(.subheadline)
        }
        .padding(.top, 6)
        .padding(.horizontal, 8)
    }
    
    private var secondRow: some View {
        HStack {
            Text("\(launchSite.territory), \(launchSite.country)")
                .font(.subheadline)
            Spacer()
            Text(launchSite.owner)
                .font(.subheadline)
        }
        .padding(.bottom, 8)
        .padding(.horizontal, 8)
    }
}
