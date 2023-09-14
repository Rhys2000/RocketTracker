//
//  VehicleView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/8/23.
//

import SwiftUI

struct VehicleView: View {
    
    @EnvironmentObject private var vm: VehicleViewModel
    
    var body: some View {
        ZStack {
            Color.theme.primaryBackground
                .ignoresSafeArea()
            
            VStack {
                SearchBarView(searchText: .constant(""))
                
                VehicleListView(vehicleList: vm.allVehicles)
                
                Spacer(minLength: 0)
            }
        }
    }
}

struct VehicleView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleView()
            .environmentObject(dev.vehicleVM)
    }
}
