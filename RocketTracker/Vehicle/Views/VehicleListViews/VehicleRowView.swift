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
            
            dataStack
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
        Image(vehicle.vehicleName.replacingOccurrences(of: " ", with: ""))
            .resizable()
            .frame(width: 170)
            .frame(maxHeight: textHeight)
    }
    
    private var dataStack: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text(vehicle.vehicleName)
                .font(.title2)
                .bold()
                .foregroundColor(Color.theme.primaryText)
            
            LabelDataView(label: "Total Missions: ", data: "\(vehicle.missionsFlown)")
            LabelDataView(label: "Successful Missions: ", data: "\(vehicle.successfulMissions)")
            LabelDataView(label: "Partial Successes: ", data: "\(vehicle.partiallySuccessfulMissions)")
            LabelDataView(label: "Failed Missions: ", data: "\(vehicle.failedMissions)")
            LabelDataView(label: "Success Rate: ", data: String(format: "%.2f", vehicle.successRate) + "%")
            LabelDataView(label: "Success Streak: ", data: "\(vehicle.successStreak)")
            if(vehicle.vehicleVariants.count > 1) {
                LabelDataView(label: "Total Variants: ", data: "\(vehicle.vehicleVariants.count)")
            }
        }
    }
}
