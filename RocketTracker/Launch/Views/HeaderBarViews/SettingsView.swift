//
//  SettingsView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/28/23.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var vm: LaunchViewModel

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Appearance")) {
                    Text("Hello")
                }
                Section(header: Text("Units")) {
                    Text("Imperial/Metric")
                    Text("Farenheit/Celsius")
                    Text("Military Time")
                }
                Section(header: Text("Notifications")) {
                    Text("Hello")
                }
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    CloseSheetButton(closeSheet: $vm.isSettingsPresented)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(LaunchViewModel())
    }
}

