//
//  FairingDataView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/5/23.
//

import SwiftUI

struct FairingDataView: View {
    
    let fairings: [Fairing]
    let pastLaunch: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("- " + getNumberOfFlights())
                .foregroundColor(Color.theme.tertiaryText)
            
            Text("- " + getRecoveryMethod())
                .foregroundColor(Color.theme.tertiaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 4)
    }
}

struct FairingDataView_Previews: PreviewProvider {
    static var previews: some View {
        FairingDataView(fairings: dev.fairings, pastLaunch: true)
    }
}

extension FairingDataView {
    
    func getNumberOfFlights() -> String {
        let firstFairing = fairings[0], secondFairing = fairings[1]
        let tense = pastLaunch ? "will be flying" : "flew"
        
        if(firstFairing.flightNumber == secondFairing.flightNumber) {
            return "Both fairing halves \(tense) for the \(firstFairing.flightNumber.addNumberEnding()) time on this launch"
        } else {
            return "One fairing half \(tense) for the \(firstFairing.flightNumber.addNumberEnding()) time and the other \(tense) for the \(secondFairing.flightNumber.addNumberEnding()) time on this launch"
        }
    }
    
    func getRecoveryMethod() -> String {
        let firstFairing = fairings[0], secondFairing = fairings[1]
        
        return ""
    }
}
