//
//  LabelLinkStackView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/8/23.
//

import SwiftUI

struct LabelLinkStackView: View {
    
    let labelName: String
    let url: URL
    let pastLaunch: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            Text(labelName)
                .font(.title3)
                .foregroundColor(Color.theme.secondaryText)
            Text(pastLaunch ? "Watch Again" : "Watch Live")
                .underline()
                .foregroundColor(Color.theme.accent)
                .font(.title3)
                .bold()
                .onTapGesture {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                }
            Spacer()
        }
    }
}

struct LabelLinkStackView_Previews: PreviewProvider {
    static var previews: some View {
        LabelLinkStackView(labelName: "Livestream:", url: URL(string: dev.launch.livestreamLink)!, pastLaunch: dev.launch.pastLaunch)
    }
}
