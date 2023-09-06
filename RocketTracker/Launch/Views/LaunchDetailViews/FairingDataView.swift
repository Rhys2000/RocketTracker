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
        let tense = pastLaunch ? "flew" : "will be flying"
        
        if(firstFairing.flightNumber == 0) {
            return "The number of flights for these fairing halves is unknown"
        } else if(firstFairing.flightNumber == secondFairing.flightNumber) {
            return "Both fairing halves \(tense) for the \(firstFairing.flightNumber.addNumberEnding()) time"
        } else {
            return "One fairing half \(tense) for the \(firstFairing.flightNumber.addNumberEnding()) time and the other \(tense) for the \(secondFairing.flightNumber.addNumberEnding()) time"
        }
    }
    
    func getRecoveryMethod() -> String {
        let firstFairing = fairings[0], secondFairing = fairings[1]
        
        if(pastLaunch) {
            if(firstFairing.method == .netCatch && secondFairing.method == .netCatch && firstFairing.outcome == .success && secondFairing.outcome == .success) {
                return "Both fairing halves were successfully caught and recovered \(firstFairing.distance) km downrange by \(firstFairing.location) and \(secondFairing.location)"
            } else if(firstFairing.method == .netCatch && secondFairing.method == .netCatch && firstFairing.outcome == .failure && secondFairing.outcome == .failure) {
                return "Both fairing halves failed to be caught by \(firstFairing.location) and \(secondFairing.location) \(firstFairing.distance) km downrange and could not be recovered"
            } else if(firstFairing.method == .netCatch && secondFairing.method == .splashdown && firstFairing.outcome == .partialSuccess && secondFairing.outcome == .success) {
                return "One fairing half attempted to be caught by \(firstFairing.location) but was recovered from the water and the other half successfully splashed down and was recovered \(secondFairing.distance) km downrange in the \(secondFairing.location) ocean"
            }
            
            else if(firstFairing.method == .splashdown && secondFairing.method == .splashdown && firstFairing.outcome == .success && secondFairing.outcome == .success) {
                return "Both fairing halves successfully splashed down and were recovered \(firstFairing.distance) km downrange in the \(firstFairing.location) ocean"
            } else if(firstFairing.method == .splashdown && secondFairing.method == .splashdown && firstFairing.outcome == .success && secondFairing.outcome == .partialSuccess) {
                return "Both fairing halves successfully splashed down and were recovered \(firstFairing.distance) km downrange in the \(firstFairing.location) ocean but one half will most likely not be reused"
            } else if(firstFairing.method == .splashdown && secondFairing.method == .splashdown && firstFairing.outcome == .success && secondFairing.outcome == .failure) {
                return "One fairing half successfully splashed down and was recovered \(firstFairing.distance) km downrange in the \(firstFairing.location) and the other half failed to be recovered"
            } else if(firstFairing.method == .splashdown && secondFairing.method == .splashdown && firstFairing.outcome == .success && secondFairing.outcome == .unknown) {
                return "One fairing half successfully splashed down and was recovered \(firstFairing.distance) km downrange in the \(firstFairing.location) ocean and the other half was expected to splashdown but its outcome is unknown"
            } else if(firstFairing.method == .splashdown && secondFairing.method == .splashdown && firstFairing.outcome == .partialSuccess && secondFairing.outcome == .partialSuccess) {
                return "Both fairing halves splashed down and were recovered \(firstFairing.distance) km downrange in the \(firstFairing.location) ocean, but most likely will not be reused"
            } else if(firstFairing.method == .splashdown && secondFairing.method == .splashdown && firstFairing.outcome == .aborted && secondFairing.outcome == .aborted) {
                return "Both fairing halves splashed down \(firstFairing.distance) km downrange in the \(firstFairing.location) but the recovery attempt was aborted"
            }
            
            else if(firstFairing.method == .splashdown && secondFairing.method == .splashdown && firstFairing.outcome == .unknown && secondFairing.outcome == .unknown) {
                return "Both fairing halves were expected to splashdown but their outcome is unknown"
            }
            
            else if(firstFairing.method == .expended && secondFairing.method == .expended) {
                return "Both fairing halves were expended after this launch"
            }
            
            else {
                return "Need another case"
            }
        } else {
            if(firstFairing.method == secondFairing.method) {
                switch firstFairing.method {
                case .expended:
                    return "Both fairing havles will be expended after this launch"
                case .splashdown:
                    return "Both fairing halves will attempt to splashdown \(firstFairing.distance) km downrange in the \(firstFairing.location) ocean"
                case .netCatch:
                    return "Both fairing halves will attempt to be caught out of the air \(firstFairing.distance) km downrange by \(firstFairing.location) and \(secondFairing.location)"
                default:
                    print("I have an error")
                    return "Error"
                }
            } else {
                return "One fairing half will \(firstFairing.method.upcomingFairingMethod(location: firstFairing.location)) and the other half will \(secondFairing.method.upcomingFairingMethod(location: secondFairing.location)) \(firstFairing.distance) km downrange"
            }
        }
    }
}
