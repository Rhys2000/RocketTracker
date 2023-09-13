//
//  VehicleListView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/12/23.
//

import SwiftUI

struct VehicleListView: View {
    
    let vehicleList: [Vehicle]
    
    var body: some View {
        List {
            ForEach(vehicleList) { vehicle in
                VehicleRowView(vehicle: vehicle)
                    .listRowBackground(Color.theme.primaryBackground)
                    .listRowSeparator(.hidden)
                    .shadow(color: Color.theme.accent.opacity(1), radius: 10)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct VehicleListView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleListView(vehicleList: dev.vehicleVM.allVehicles)
    }
}
