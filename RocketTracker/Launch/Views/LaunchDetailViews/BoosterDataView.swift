//
//  BoosterDataView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/5/23.
//

import SwiftUI

struct BoosterDataView: View {
    
    let booster: Booster
    let parentLaunch: Launch
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(booster.name + ":")
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            
            Text("- " + booster.getNumberOfFlights())
                .foregroundColor(Color.theme.tertiaryText)
            
            if(booster.flightNumber > 1) {
                Text("- " + booster.getDaysSinceLastFlight(launch: parentLaunch))
                    .foregroundColor(Color.theme.tertiaryText)
            }
            
            Text("- " + booster.formatRecoveryMethod(pastLaunch: parentLaunch.pastLaunch))
                .foregroundColor(Color.theme.tertiaryText)
            
            if(booster.flightNumber > 1) {
                Text("- " + booster.getPreviousMissions(launch: parentLaunch))
                    .foregroundColor(Color.theme.tertiaryText)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(booster.outcome != .notAvailable ? RecoveryOutcomeLabelView(outcome: booster.outcome, font: .headline).padding(.trailing, -8) : nil, alignment: .topTrailing)
        .padding(.vertical, 4)
    }
}

struct BoosterDataView_Previews: PreviewProvider {
    static var previews: some View {
        BoosterDataView(booster: dev.booster, parentLaunch: dev.launch)
    }
}
