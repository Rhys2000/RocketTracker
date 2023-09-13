//
//  LabelDataView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/12/23.
//

import SwiftUI

struct LabelDataView: View {
    
    let label: String
    let data: String
    
    var body: some View {
        Text(label)
            .font(.headline)
            .foregroundColor(Color.theme.secondaryText) +
        Text(data)
            .foregroundColor(Color.theme.tertiaryText)
    }
}

struct LabelDataView_Previews: PreviewProvider {
    static var previews: some View {
        LabelDataView(label: "Successful Missions: ", data: "234")
    }
}
