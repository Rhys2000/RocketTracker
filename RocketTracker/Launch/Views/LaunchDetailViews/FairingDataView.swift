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
            HStack(spacing: 0) {
                Text("Outcome:")
                    .font(.headline)
                    .foregroundColor(Color.theme.secondaryText)
                Spacer()
                ForEach(fairings) { fairing in
                    RecoveryOutcomeLabelView(outcome: fairing.outcome, font: .headline)
                        .padding(.horizontal, -6)
                }
            }
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
            }
            else if(firstFairing.method == .netCatch && secondFairing.method == .netCatch && firstFairing.outcome == .success && secondFairing.outcome == .partialSuccess) {
                return "One fairing half was successfully caught and recovered by \(firstFairing.location) and the other half attempted to be caught by \(secondFairing.location) but was recovered from the water \(firstFairing.distance) km downrange"
            }
            else if(firstFairing.method == .netCatch && secondFairing.method == .netCatch && firstFairing.outcome == .success && secondFairing.outcome == .failure) {
                return "One fairing half was successfully caught and recovered by \(firstFairing.location) \(firstFairing.distance) km downrange and the other half failed to be recovered by \(secondFairing.location)"
            }
            else if(firstFairing.method == .netCatch && secondFairing.method == .netCatch && firstFairing.outcome == .partialSuccess && secondFairing.outcome == .partialSuccess) {
                return "Both fairing halves were attempted to be caught by \(firstFairing.location) and \(secondFairing.location) but were recovered from the water \(firstFairing.distance) km downrange instead"
            }
            else if(firstFairing.method == .netCatch && secondFairing.method == .netCatch && firstFairing.outcome == .failure && secondFairing.outcome == .failure) {
                return "Both fairing halves failed to be caught by \(firstFairing.location) and \(secondFairing.location) \(firstFairing.distance) km downrange and could not be recovered"
            }
            else if(firstFairing.method == .netCatch && secondFairing.method == .netCatch && firstFairing.outcome == .aborted && secondFairing.outcome == .aborted) {
                return "Both fairings halves were meant to be caught by \(firstFairing.location) and \(secondFairing.location) \(firstFairing.distance) km downrange but the recovery attempt was aborted"
            }
            else if(firstFairing.method == .netCatch && secondFairing.method == .splashdown && firstFairing.outcome == .success && secondFairing.outcome == .success) {
                return "One fairing half was successfully caught by \(firstFairing.location) and the other half successfully splashed down and was recovered \(secondFairing.distance) km downrange in the \(secondFairing.location) ocean"
            }
            else if(firstFairing.method == .netCatch && secondFairing.method == .splashdown && firstFairing.outcome == .success && secondFairing.outcome == .failure) {
                return "One fairing half was successfully caught by \(firstFairing.location) and the other half failed to be recovered after splashing down \(secondFairing.distance) km downrange in the \(secondFairing.location) ocean"
            }
            else if(firstFairing.method == .netCatch && secondFairing.method == .splashdown && firstFairing.outcome == .partialSuccess && secondFairing.outcome == .success) {
                return "One fairing half was attempted to be caught by \(firstFairing.location) but was recovered from the water and the other half successfully splashed down and was recovered \(secondFairing.distance) km downrange in the \(secondFairing.location) ocean"
            }
            else if(firstFairing.method == .netCatch && secondFairing.method == .splashdown && firstFairing.outcome == .failure && secondFairing.outcome == .success) {
                return "One fairing half failed to be caught by \(firstFairing.location) and could not be recovered while the other half successfully splashed down and was recovered \(secondFairing.distance) km downrange in the \(secondFairing.location) ocean"
            }
            else if(firstFairing.method == .netCatch && secondFairing.method == .splashdown && firstFairing.outcome == .failure && secondFairing.outcome == .failure) {
                return "One fairing half attempted to be caught by \(firstFairing.location) and failed while the other half attempted to splashdown \(secondFairing.distance) km downrange in the \(secondFairing.location) and failed to be recovered"
            }
            else if(firstFairing.method == .netCatch && secondFairing.method == .expended && firstFairing.outcome == .partialSuccess) {
                return "One fairing half attempted to be caught by \(firstFairing.location) \(firstFairing.distance) km downrange but was recovered from the water instead and the other half was expended"
            }
            
            else if(firstFairing.method == .splashdown && secondFairing.method == .splashdown && firstFairing.outcome == .success && secondFairing.outcome == .success) {
                return "Both fairing halves successfully splashed down and were recovered \(firstFairing.distance) km downrange in the \(firstFairing.location) ocean"
            }
            else if(firstFairing.method == .splashdown && secondFairing.method == .splashdown && firstFairing.outcome == .success && secondFairing.outcome == .partialSuccess) {
                return "Both fairing halves successfully splashed down and were recovered \(firstFairing.distance) km downrange in the \(firstFairing.location) ocean but one half will most likely not be reused"
            }
            else if(firstFairing.method == .splashdown && secondFairing.method == .splashdown && firstFairing.outcome == .success && secondFairing.outcome == .failure) {
                return "One fairing half successfully splashed down and was recovered \(firstFairing.distance) km downrange in the \(firstFairing.location) and the other half failed to be recovered"
            }
            else if(firstFairing.method == .splashdown && secondFairing.method == .splashdown && firstFairing.outcome == .success && secondFairing.outcome == .unknown) {
                return "One fairing half successfully splashed down and was recovered \(firstFairing.distance) km downrange in the \(firstFairing.location) ocean and the other half was expected to splashdown but its outcome is unknown"
            }
            else if(firstFairing.method == .splashdown && secondFairing.method == .splashdown && firstFairing.outcome == .partialSuccess && secondFairing.outcome == .partialSuccess) {
                return "Both fairing halves splashed down and were recovered \(firstFairing.distance) km downrange in the \(firstFairing.location) ocean, but most likely will not be reused"
            }
            else if(firstFairing.method == .splashdown && secondFairing.method == .splashdown && firstFairing.outcome == .failure && secondFairing.outcome == .failure) {
                return "Both fairing halves attempted to splashdown \(firstFairing.distance) km downrange in the \(firstFairing.location) but failed to be recovered"
            }
            else if(firstFairing.method == .splashdown && secondFairing.method == .splashdown && firstFairing.outcome == .aborted && secondFairing.outcome == .aborted) {
                return "Both fairing halves splashed down \(firstFairing.distance) km downrange in the \(firstFairing.location) but the recovery attempt was aborted"
            }
            else if(firstFairing.method == .splashdown && secondFairing.method == .splashdown && firstFairing.outcome == .unknown && secondFairing.outcome == .unknown) {
                return "Both fairing halves were expected to splashdown but their outcome is unknown"
            }
            else if(firstFairing.method == .splashdown && secondFairing.method == .expended && firstFairing.outcome == .success) {
                return "One fairing half successfully splashed down \(firstFairing.distance) km downrange in the \(firstFairing.location) ocean and was recovered while the other half was expended"
            }
            else if(firstFairing.method == .splashdown && secondFairing.method == .expended && firstFairing.outcome == .partialSuccess) {
                return "One fairing half attempted to splashdown \(firstFairing.distance) km downrange in the \(firstFairing.location) ocean but most likely wont be reused and the other half was expended"
            }
            else if(firstFairing.method == .splashdown && secondFairing.method == .expended && firstFairing.outcome == .failure) {
                return "One fairing half attempted to splashdown \(firstFairing.distance) km downrange in the \(firstFairing.location) ocean and failed to be recovered while the other half was expended"
            }
            else if(firstFairing.method == .splashdown && secondFairing.method == .expended && firstFairing.outcome == .unknown) {
                return "One fairing half attempted to splash down \(firstFairing.distance) km downrange but its outcome is unknown and the other half was expended"
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
