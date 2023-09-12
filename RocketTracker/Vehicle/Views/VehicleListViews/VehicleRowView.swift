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
                LabelDataStackView(labelName: "Total Missions:", data: [String(vehicle.missionsFlown)])
                LabelDataStackView(labelName: "Successful Missions:", data: [""/*String(vehicle.successfulMissions)*/])
                    
                LabelDataStackView(labelName: "Partial Successes:", data: [String(vehicle.partiallySuccessfulMissions)])
                LabelDataStackView(labelName: "Failed Missions:", data: [String(vehicle.failedMissions)])
                LabelDataStackView(labelName: "Success Rate:", data: [String(vehicle.successRate)])
                LabelDataStackView(labelName: "Success Streak:", data: [String(vehicle.successStreak)])
            }
            .background(Color.red)
            .padding(.leading, 8)
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
            .frame(width: 150)
            .frame(maxHeight: textHeight)
    }
}
