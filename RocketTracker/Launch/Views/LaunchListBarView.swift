//
//  LaunchListBarView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/23/23.
//

import SwiftUI

struct LaunchListBarView: View {
    var body: some View {
        HStack {
            Text("Future")
                //.background(Color.orange)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.primaryText)
                .frame(width: UIScreen.main.bounds.width / 2, height: 40)
            Spacer()
            Rectangle()
                .frame(width: 1, height: 40)
                .background(Color.black)
            Spacer()
            Text("Past")
                //.background(Color.green)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.primaryText)
                .frame(width: UIScreen.main.bounds.width / 2)
        }
        .padding(.horizontal)
        .background(Color.theme.primaryBackground)
        .shadow(radius: 10)
    }
}

struct LaunchListBarView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchListBarView()
    }
}
