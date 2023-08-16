//
//  RecoveryLabelView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/15/23.
//

import SwiftUI

struct RecoveryLabelView: View {
    
    let color: Color
    let text: String
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .background(Color.blue)
    }
}

struct RecoveryLabelView_Previews: PreviewProvider {
    static var previews: some View {
        RecoveryLabelView(color: Color.purple, text: "RTLS")
    }
}
