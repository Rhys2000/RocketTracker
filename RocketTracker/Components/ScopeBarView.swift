//
//  ScopeBarView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/25/23.
//

import SwiftUI

struct ScopeBarView: View {
    
    @State private var isOverlayVisible = false
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                Rectangle()
                    .frame(height: 40)
                    .foregroundColor(Color.theme.secondaryBackground)
                    .cornerRadius(20, corners: [.topLeft, .bottomLeft])
                    .onTapGesture {
                        self.isOverlayVisible.toggle()
                    }
                    .overlay(
                        Text("Upcoming")
                            .foregroundColor(Color.theme.primaryText)
                    )
                    .disabled(!isOverlayVisible)
                Rectangle()
                    .frame(width: 1, height: 40)
                Rectangle()
                    .frame(height: 40)
                    .foregroundColor(Color.theme.secondaryBackground)
                    .cornerRadius(20, corners: [.topRight, .bottomRight])
                    .onTapGesture {
                        self.isOverlayVisible.toggle()
                    }
                    .overlay(
                        Text("Previous")
                            .foregroundColor(Color.theme.primaryText)
                    )
                    .disabled(isOverlayVisible)
            }
            .padding(.horizontal)
            .shadow(color: Color.theme.accent.opacity(0.4), radius: 10)
            
            HStack(spacing: 0) {
                Rectangle()
                    .frame(height: 40)
                    .background(Color.black)
                    .cornerRadius(20, corners: [.topLeft, .bottomLeft])
                    .opacity(isOverlayVisible ? 0.3 : 0.0)
                    .transition(.move(edge: .trailing))
                    .animation(.easeInOut, value: isOverlayVisible)
                Rectangle()
                    .frame(width: 1, height: 40)
                Rectangle()
                    .frame(height: 40)
                    .background(Color.black)
                    .cornerRadius(20, corners: [.topRight, .bottomRight])
                    .opacity(isOverlayVisible ? 0.0 : 0.3)
                    .transition(.move(edge: .leading))
                    .animation(.easeInOut, value: !isOverlayVisible)
            }
            .padding(.horizontal)
        }
    }
}

struct ScopeBarView_Previews: PreviewProvider {
    static var previews: some View {
        ScopeBarView()
    }
}
