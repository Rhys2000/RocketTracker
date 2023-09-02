//
//  DetailSectionHeaderView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/1/23.
//

import SwiftUI

struct DetailSectionHeaderView: View {
    
    let sectionName: String
    
    var body: some View {
        Text(sectionName)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color.theme.primaryText)
            .padding(.leading, 8)
            .padding(.bottom, 1)
    }
}

struct DetailSectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSectionHeaderView(sectionName: "Status")
    }
}
