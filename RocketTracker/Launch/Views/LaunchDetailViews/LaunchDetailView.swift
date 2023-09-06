//
//  LaunchDetailView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/28/23.
//

import SwiftUI

struct LaunchDetailView: View {
    
    @EnvironmentObject private var vm: LaunchViewModel
    @State private var showFullDescription: Bool = false
    
    let launch: Launch
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ImageTabView(height: 300, name: launch.vehicleName, numberOfImages: 4)
                
                statusHeader
                roundedBackground(statusBody, Color.theme.secondaryBackground)
                
                DetailSectionHeaderView(sectionName: "Details")
                roundedBackground(fullDetailBody, Color.theme.secondaryBackground)

                DetailSectionHeaderView(sectionName: "Recovery")
                roundedBackground(recoveryBody, Color.theme.secondaryBackground)
                
                DetailSectionHeaderView(sectionName: "Location")
                roundedBackground(LaunchSiteRowView(launchSite: vm.launchSite!), Color.clear)
//
//                sectionHeader("Payloads")
            }
            .padding(.bottom, 32)
            
//            VStack(alignment: .leading) {
//                sectionHeader("Vehicles")
//                sectionHeader("Milestones")
//                sectionHeader("Rocket")
//                sectionHeader("Location")
//            }
//            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .ignoresSafeArea()
        .background(Color.theme.primaryBackground)
        .overlay(backButton, alignment: .topTrailing)
        .overlay(shortMissionName, alignment: .topLeading)
    }
    
//    func fairingRecoveryData() -> [String] {
//        var stringArray: [String] = []
//        let time = launch.time.getBool()
//
//        if(launch.numberOfFairingFlights[0] == "0" && launch.numberOfFairingFlights[1] == "0") {
//            stringArray.append("The number of flights for these fairing halves is unknown")
//        } else if(launch.numberOfFairingFlights[0] == launch.numberOfFairingFlights[1]) {
//            let tempString = time ? "was" : "will be"
//            stringArray.append("This \(tempString) the \(addNumberEnding(Int(launch.numberOfFairingFlights[0])!)) flight for both of these fairing halves")
//        } else {
//            let tempString = time ? " flew " : "is flying"
//            stringArray.append("One fairing half \(tempString) for the \(addNumberEnding(Int(launch.numberOfFairingFlights[0])!)) time and the other half \(tempString) for the \(addNumberEnding(Int(launch.numberOfFairingFlights[1])!))")
//        }
//        return stringArray
//    }
    

}

struct LaunchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchDetailView(launch: dev.launch)
            .environmentObject(LaunchViewModel())
    }
}

extension LaunchDetailView {
    
    
//    private func fairingDataStack(_ data: [String]) -> some View {
//        VStack(alignment: .leading, spacing: 5) {
//            Text("Version: " + launch.fairingRecoveryDistance)
//                .font(.headline)
//                .foregroundColor(Color.theme.secondaryText)
//            ForEach(data, id: \.self) { datam in
//                Text(datam)
//                    .foregroundColor(Color.brown)
//            }
//        }
//        .frame(maxWidth: .infinity, alignment: .leading)
//        .padding(.vertical, 8)
//    }
    
    //Revised
    private var statusHeader: some View {
        HStack {
            DetailSectionHeaderView(sectionName: "Status")
            Spacer()
            RecoveryOutcomeLabelView(outcome: launch.missionOutcome, font: .title)
        }
        .padding(.bottom, 1)
    }
    
    //Revised
    private var statusBody: some View {
        VStack(spacing: 10) {
            LabelDataStackView(labelName: "Liftoff:", data: [launch.liftOffTime.statusTime(timezone: TimeZone.current), launch.liftOffTime.statusTime(timezone: TimeZone(abbreviation: "UTC")!)])
            LabelDataStackView(labelName: "Outcome:", data: [launch.missionOutcome.getLaunchOutcomeDescription()])
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
    }
    
    //Revised
    private var detailsDataBody: some View {
        VStack(alignment: .leading, spacing: 10) {
            LabelDataStackView(labelName: "Name:", data: ["\(launch.missionName) (\(launch.abbrMissionName))"])
            
            if(!launch.altMissionName.isEmpty) {
                LabelDataStackView(labelName: "Alternative Name:", data: [launch.altMissionName])
            }
            
            LabelDataStackView(labelName: "Location:", data: [vm.launchSite?.getLaunchSiteAndLaunchPadFullName(vm.launchPad!) ?? ""])
            
            LabelDataStackView(labelName: "Provider:", data: [launch.launchProvider])
            
            let launchVehicle = "\(launch.vehicleName) \(launch.vehicleVariant)"
            LabelDataStackView(labelName: "Vehicle:", data: [launchVehicle])
            
            if(!launch.boosterData[0].isEmpty) {
                let labelName = (launch.boosterData.count > 1 ? "Boosters:" : "Booster:")
                LabelDataStackView(labelName: labelName, data: launch.boosterData)
            }

//            labelDataStack("Customer:", ["Future Data Goes Here"])
            
            let orbitData = "\(launch.orbitalDestination.getFullName()) (\(launch.orbitalDestination.rawValue))"
            LabelDataStackView(labelName: "Orbit:", data: [orbitData])
            
            if(!launch.staticFireGap.isEmpty) {
                let day = (Int(launch.staticFireGap)! > 1) ? "days" : "day"
                LabelDataStackView(labelName: "Static Fire:", data: ["Performed \(launch.staticFireGap) \(day) before launch"])
            }
            
            if(Bool(launch.crewedLaunch)!) {
                LabelDataStackView(labelName: "Crewed:", data: ["Yes, carrying 4 astronauts into space"])
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 2)
    }
    
    //Revised
    private var descriptionDataBody: some View {
        VStack(spacing: 8) {
            Text("Description:").font(.headline).foregroundColor(Color.theme.secondaryText) + Text(showFullDescription ? launch.formatDescription(stringArray: launch.description) : launch.formatDescription(stringArray: [launch.description[0]]) ).foregroundColor(Color.theme.tertiaryText)
            if(launch.description.count > 1) {
                HStack(spacing: 4) {
                    Text(showFullDescription ? "  Show Less  " : "  Show More  ")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color.theme.primaryText)
                        .background(Color.theme.tertiaryBackground)
                        .cornerRadius(10, corners: .allCorners)
                    Image(systemName: "chevron.down")
                        .rotationEffect(Angle(degrees: showFullDescription ? 180 : 0))
                        .foregroundColor(Color.theme.primaryText)
                }
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showFullDescription.toggle()
                    }
                }
            }
        }
    }
    
    //Revised
    private var fullDetailBody: some View {
        VStack {
            detailsDataBody
            if(!launch.description[0].isEmpty) {
                descriptionDataBody
            }
        }
        .padding(.vertical, 8)
    }
    
    //Revised
    private var boosterRecoveryData: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Booster Recovery")
                .font(.title3)
                .bold()
                .foregroundColor(Color.theme.secondaryText)
            ForEach(launch.boosters) { booster in
                roundedBackground(BoosterDataView(booster: booster, parentLaunch: launch), Color.theme.tertiaryBackground)
                    .padding(.horizontal, -8)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    //Revised
    private var fairingRecoveryData: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Fairing Recovery")
                .font(.title3)
                .bold()
                .foregroundColor(Color.theme.secondaryText)
            roundedBackground(FairingDataView(fairings: launch.fairings, pastLaunch: launch.pastLaunch), Color.theme.tertiaryBackground)
                .padding(.horizontal, -8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    //Revised
    private var recoveryBody: some View {
        VStack {
            if(!launch.boosterData[0].isEmpty) {
                boosterRecoveryData
            }
            
            if(!launch.numberOfFairingFlights[0].isEmpty) {
                fairingRecoveryData
            }
        }
        .padding(.vertical, 8)
    }
    
    //Revised
    private var backButton: some View {
        Image(systemName: "xmark")
            .font(.headline)
            .padding(12)
            .foregroundColor(Color.theme.primaryText)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .shadow(radius: 4)
            .padding()
            .onTapGesture {
                vm.launch = nil
                vm.launchSite = nil
                vm.launchPad = nil
            }
    }
    
    //Not Fixed
    private var shortMissionName: some View {
        Text(launch.abbrMissionName.isEmpty ? launch.missionName : launch.abbrMissionName)
            .font(.headline)
            .bold()
            .padding(12)
            .foregroundColor(Color.theme.primaryText)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .shadow(radius: 4)
            .padding()
    }
}
