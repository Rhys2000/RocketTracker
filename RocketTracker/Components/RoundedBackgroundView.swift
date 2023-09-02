//
//  RoundedBackgroundView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/1/23.
//

import SwiftUI

struct RoundedBackgroundView<Content: View>: View {
    
    let view: Content
    
    var body: some View {
        view
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.theme.secondaryBackground)
        )
        .padding(.horizontal, 8)
    }
}

struct RoundedBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedBackgroundView(view: DetailSectionHeaderView(sectionName: "Status"))
    }
}
