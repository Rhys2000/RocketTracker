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
        VStack(alignment: .leading) {
            Text(booster.name + ":")
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            Text(booster.getNumberOfFlights())
            if(booster.flightNumber > 1) {
                Text(booster.getDaysSinceLastFlight(launch: parentLaunch))
            }
            Text(booster.formatRecoveryMethod(pastLaunch: parentLaunch.pastLaunch))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 4)
        //.overlay(outcome != .notAvailable ? recoveryLabel(outcome: outcome) : nil, alignment: .topTrailing)
    }
}

struct BoosterDataView_Previews: PreviewProvider {
    static var previews: some View {
        BoosterDataView(booster: dev.booster, parentLaunch: dev.launch)
    }
}
