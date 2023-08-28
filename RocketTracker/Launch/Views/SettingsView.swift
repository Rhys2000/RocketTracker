//
//  SettingsView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/28/23.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var isDarkModeOn = UserDefaults.standard.bool(forKey: "isDarkModeOn")

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Appearance")) {
                    Toggle(isOn: $isDarkModeOn, label: {
                        Text("Dark Mode")
                    })
                    .onChange(of: isDarkModeOn) { newValue in
                        // Update the appearance mode and save it to UserDefaults
                        UserDefaults.standard.set(newValue, forKey: "isDarkModeOn")
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = newValue ? .dark : .light
                    }
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
