//
//  VehicleRowView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/8/23.
//

import SwiftUI

struct VehicleRowView: View {
    
    @EnvironmentObject private var vm: VehicleViewModel
    let vehicle: Vehicle
    
    @State var textHeight = CGFloat.zero
    
    var body: some View {
        HStack(spacing: 0) {
            imageView
            
            VStack(alignment: .leading, spacing: 4) {
                Text(vehicle.vehicleName)
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.theme.primaryText)
                LabelDataStackView(labelName: "Total Missions:", data: ["\(vehicle.missionsFlown)"])
                LabelDataStackView(labelName: "Successes:", data: ["\(vehicle.successfulMissions)"])
                LabelDataStackView(labelName: "Partials:", data: ["\(vehicle.partiallySuccessfulMissions)"])
                LabelDataStackView(labelName: "Failures:", data: ["\(vehicle.failedMissions)"])
                LabelDataStackView(labelName: "Success Rate:", data: ["\(vehicle.successRate)"])
                LabelDataStackView(labelName: "Streak:", data: ["\(vehicle.successStreak)"])
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.purple.opacity(0.4))
            .padding(.vertical, 8)
            .padding(.leading, 8)
            .padding(.trailing, -8)
            .overlay(
                GeometryReader(content: { geometry in
                    Color.clear
                        .onAppear(perform: {
                            self.textHeight = geometry.frame(in: .local).size.height
                        })
                    })
                )
            Spacer()
        }
        .background(Color.theme.secondaryBackground)
        .cornerRadius(15, corners: .allCorners)
        .onTapGesture {
            vm.vehicle = vehicle
        }
    }
}

struct VehicleRowView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleRowView(vehicle: dev.vehicle)
    }
}

extension VehicleRowView {
    
    private var imageView: some View {
        Image("Falcon9Block5")
            .resizable()
            .frame(width: 130)
            .frame(maxHeight: textHeight)
    }
}
