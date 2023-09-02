//
//  RecoveryOutcomeLabelView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/1/23.
//

import SwiftUI

struct RecoveryOutcomeLabelView: View {
    
    let outcome: Outcome
    let font: Font
    
    var body: some View {
        let text = Text("  \(outcome.rawValue)  ")
            .font(font)
            .foregroundColor(Color.white)
            .fontWeight(.bold)
        roundedBackground(text, outcome.getBackgroundColor())
    }
}

struct RecoveryOutcomeLabelView_Previews: PreviewProvider {
    static var previews: some View {
        RecoveryOutcomeLabelView(outcome: .explosion, font: .headline)
    }
}
