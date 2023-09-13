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
                vehicleName
                totalMissionsText
                successfulMissions
                partialMissions
                failedMissions
                successRate
                successStreak
                numberOfVariants
            }
            .padding(.vertical, 8)
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
            .frame(width: 170)
            .frame(maxHeight: textHeight)
    }
    
    private var vehicleName: some View {
        Text(vehicle.vehicleName)
            .font(.title2)
            .bold()
            .foregroundColor(Color.theme.primaryText)
    }
    
    private var totalMissionsText: some View {
        LabelDataView(label: "Total Missions: ", data: "\(vehicle.missionsFlown)")
    }
    
    private var successfulMissions: some View {
        LabelDataView(label: "Successful Missions: ", data: "\(vehicle.successfulMissions)")
    }
    
    private var partialMissions: some View {
        Text("Partial Successes: ") + Text("\(vehicle.partiallySuccessfulMissions)")
    }
    
    private var failedMissions: some View {
        Text("Failed Misssions: ") + Text("\(vehicle.failedMissions)")
    }
    
    private var successRate: some View {
        Text("Success Rate: ") + Text(String(format: "%.2f", vehicle.successRate) + "%")
    }
    
    private var successStreak: some View {
        Text("Success Streak: ") + Text("\(vehicle.successStreak)")
    }
    
    private var numberOfVariants: some View {
        Text("Total Variants: ") + Text("\(vehicle.vehicleVariants.count)")
    }
}
