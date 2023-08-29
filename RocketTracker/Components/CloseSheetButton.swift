//
//  CloseSheetButton.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/28/23.
//

import SwiftUI

struct CloseSheetButton: View {
    
    @Binding var closeSheet: Bool
    
    var body: some View {
        Button {
            closeSheet.toggle()
        } label: {
            Image(systemName: "xmark")
                .font(.subheadline)
                .bold()
                .padding(8)
                .foregroundColor(Color.theme.primaryText)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding(.trailing, 4)
                .padding(.top, 8)
        }
    }
}

struct CloseSheetButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseSheetButton(closeSheet: .constant(true))
    }
}
