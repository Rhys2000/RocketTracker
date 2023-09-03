//
//  LabelDataStackView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/2/23.
//

import SwiftUI

struct LabelDataStackView: View {
    
    let labelName: String
    let data: [String]
    
    var body: some View {
        HStack(alignment: .top) {
            Text(labelName)
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            VStack(alignment: .leading) {
                ForEach(data, id: \.self) { datam in
                    Text(datam)
                        .foregroundColor(Color.gray)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct LabelDataStackView_Previews: PreviewProvider {
    static var previews: some View {
        LabelDataStackView(labelName: "Outcome:", data: ["Hello", "Hi There"])
    }
}
