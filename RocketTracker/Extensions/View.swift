//
//  View.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/16/23.
//

import Foundation
import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func roundedBackground(_ view: some View, _ color: Color) -> some View {
        view
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(color)
        )
        .padding(.horizontal, 8)
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
