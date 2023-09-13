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
                
            }
        }
    }
}

struct VehicleListView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleListView(vehicleList: [dev.vehicle], body: <#T##View#>)
    }
}
