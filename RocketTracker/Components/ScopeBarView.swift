//
//  ScopeBarView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/25/23.
//

import SwiftUI

struct ScopeBarView: View {
    
    @Binding var overlayBool: Bool
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                Rectangle()
                    .frame(height: 40)
                    .foregroundColor(Color.theme.secondaryBackground)
                    .cornerRadius(20, corners: [.topLeft, .bottomLeft])
                    .onTapGesture {
                        self.overlayBool.toggle()
                    }
                    .overlay(
                        Text("Upcoming")
                            .foregroundColor(Color.theme.primaryText)
                    )
                    .disabled(overlayBool)
                Rectangle()
                    .frame(width: 1, height: 40)
                Rectangle()
                    .frame(height: 40)
                    .foregroundColor(Color.theme.secondaryBackground)
                    .cornerRadius(20, corners: [.topRight, .bottomRight])
                    .onTapGesture {
                        self.overlayBool.toggle()
                    }
                    .overlay(
                        Text("Previous")
                            .foregroundColor(Color.theme.primaryText)
                    )
                    .disabled(!overlayBool)
            }
            .padding(.horizontal)
            .shadow(color: Color.theme.accent.opacity(0.4), radius: 10)
            
            HStack(spacing: 0) {
                Rectangle()
                    .frame(height: 40)
                    .background(Color.black)
                    .cornerRadius(20, corners: [.topLeft, .bottomLeft])
                    .opacity(overlayBool ? 0.0 : 0.3)
                    .transition(.move(edge: .trailing))
                    .animation(.easeInOut, value: overlayBool)
                Rectangle()
                    .frame(width: 1, height: 40)
                Rectangle()
                    .frame(height: 40)
                    .background(Color.black)
                    .cornerRadius(20, corners: [.topRight, .bottomRight])
                    .opacity(overlayBool ? 0.3 : 0.0)
                    .transition(.move(edge: .leading))
                    .animation(.easeInOut, value: !overlayBool)
            }
            .padding(.horizontal)
        }
    }
}

//struct ScopeBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScopeBarView(overlayBool: )
//    }
//}
