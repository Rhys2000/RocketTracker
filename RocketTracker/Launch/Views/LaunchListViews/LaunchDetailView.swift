//
//  LaunchDetailView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/28/23.
//

import SwiftUI

struct LaunchDetailView: View {
    
    @EnvironmentObject private var vm: LaunchViewModel
    
    @State private var showDescription: Bool = false
    
    let launch: Launch
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                imageSection
                
                statusHeader
                roundedBackground(statusBody)
                
                sectionHeader("Details")
                roundedBackground(detailsBody)
                
                sectionHeader("Description")
                roundedBackground(descriptionBody)
                
                sectionHeader("Recovery")
                
                sectionHeader("Payloads")
                
                sectionHeader("Vehicles")
            }
            
            VStack(alignment: .leading) {
                sectionHeader("Milestones")
                sectionHeader("Rocket")
                sectionHeader("Location")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .ignoresSafeArea()
        .background(Color.theme.primaryBackground)
        .overlay(backButton, alignment: .topTrailing)
        .overlay(shortMissionName, alignment: .topLeading)
    }
    
    func generateUniqueRandomNumbers() -> [String] {
        var randomNumbers = Set<String>()
        
        while randomNumbers.count < 4 {
            let randomNumber = Int.random(in: 1...20)
            randomNumbers.insert("\(launch.vehicleName)-\(randomNumber)".replacingOccurrences(of: " ", with: ""))
        }
        return Array(randomNumbers)
    }
    
    func compressDescription() -> String {
        
        var returnedString: String = ""
        
        for item in launch.description {
            if(item == launch.description.last) {
                returnedString += "\t\(item)"
            } else {
                returnedString += "\t\(item)\n\n"
            }
        }
        
        return returnedString
    }
    
//    func compressDescription(count: Int) -> String {
//
//        var returnedString: String = ""
//
//        for index in 0..<count {
//            let element = launch.description[index]
//            if(element == launch.description.last) {
//                returnedString += "\t\(element)"
//            } else {
//                returnedString += "\t\(element)\n\n"
//            }
//        }
//
//        return returnedString
//    }
    
    //Currently unused but super useful function to understand
//    func gatherPreviousMissions() -> String {
//        let allLaunches = LaunchDataService().allLaunches
//        var endIndex = allLaunches.firstIndex(where: { $0.missionName == launch.missionName })! + 1
//
//        var returnedString: String = ""
//        var launchNames: [String] = []
//
//        for index in 0..<endIndex {
//            let element = allLaunches[index]
//            for booster in launch.boosterNames {
//                if(element.boosterNames.contains(booster)) {
//                    launchNames.append(element.abbrMissionName.isEmpty ? element.missionName : element.abbrMissionName)
//                }
//            }
//        }
//
//        for missionName in launchNames {
//            if(missionName == launchNames.last) {
//                returnedString += "and \(missionName) mission"
//            } else {
//                returnedString += "\(missionName), "
//            }
//        }
//
//        if(launchNames.count > 1) {
//            returnedString += "s"
//        }
//
//        return returnedString + "."
//    }
}

struct LaunchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchDetailView(launch: dev.launch)
            .environmentObject(LaunchViewModel())
    }
}

extension LaunchDetailView {
    
    private func sectionHeader(_ name: String) -> some View {
        Text(name)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(Color.theme.primaryText)
            .padding(.leading, 8)
            .padding(.bottom, 1)
    }
    
    private func roundedBackground(_ view: some View) -> some View {
        view
        .padding(.horizontal, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.theme.secondaryBackground)
        )
        .padding(.horizontal, 8)
        .padding(.bottom, 8)
    }
    
    private func labelDataStack(_ labelName: String, _ data: [String]) -> some View {
        HStack(alignment: .top) {
            Text(labelName)
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            VStack(alignment: .leading) {
                ForEach(data, id: \.self) { datam in
                    Text(datam)
                        .foregroundColor(Color.gray)
                }
            }
            .frame(alignment: .leading)
        }
    }
    
    private var imageSection: some View {
        TabView {
            let imageNames = generateUniqueRandomNumbers()
            ForEach(imageNames, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 400)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var statusHeader: some View {
        HStack {
            sectionHeader("Status")
            Spacer()
            Text("  \(launch.missionOutcome.rawValue)  ")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(launch.missionOutcome.getBackgroundColor())
                )
                .padding(.trailing, 8)
        }
        .padding(.bottom, 1)
    }
    
    private var statusBody: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            labelDataStack("Liftoff:", [launch.liftOffTime.statusTime(timezone: TimeZone.current), launch.liftOffTime.statusTime(timezone: TimeZone(abbreviation: "UTC")!)])
            
            labelDataStack("Outcome:", [launch.missionOutcome.getMissionOutcomeDescription()])
        }
        .padding(.vertical, 8)
    }
    
    private var detailsBody: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            labelDataStack("Name:", ["\(launch.missionName) (\(launch.abbrMissionName))"])
            
            if(!launch.altMissionName.isEmpty) { labelDataStack("Alternative Name:", [launch.altMissionName]) }
            
            let locationAndPad = "\(vm.currentPad?.fullName ?? "") (\(launch.launchSitePad)), \(vm.currentLocation?.fullName ?? "") (\(vm.currentLocation?.abbrName ?? "")), \(vm.currentLocation?.territory ?? ""), \(vm.currentLocation?.country ?? "")"
            labelDataStack("Location:", [locationAndPad])
            
            labelDataStack("Provider:", [launch.launchProvider])
            
            labelDataStack("Vehicle:", ["\(launch.vehicleName) \(launch.vehicleVariant)"])
            
            if(!launch.boosterData[0].isEmpty) { labelDataStack("Booster:", launch.boosterData) }
            
            labelDataStack("Customer:", ["Future Data Goes Here"])
            
            labelDataStack("Orbit:", ["\(launch.orbitalDestination.getFullName()) (\(launch.orbitalDestination.rawValue))"])
            
            if(launch.staticFire) {
                let day: String = (Int(launch.staticFireGap)! > 1) ? "days" : "day"
                labelDataStack("Static Fire:", ["Performed \(launch.staticFireGap) \(day) before launch"])
            }
            
            if(Bool(launch.crewedLaunch)!) { labelDataStack("Crewed:", ["Carrying 4 astronauts into space"]) }
            
        }
        .padding(.vertical, 8)
    }

    private var descriptionBody: some View {
        VStack {
            if(launch.description.count > 1) {
                Text(showDescription ? compressDescription() : "\t\(launch.description[0])")
                    .foregroundColor(Color.gray)
                HStack {
                    Text(showDescription ? "  Show Less  " : "  Show More  ")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .background(Color.theme.accent)
                        .cornerRadius(10, corners: .allCorners)
                        .padding(.top, 1)
                    Image(systemName: "chevron.down")
                        .rotationEffect(Angle(degrees: showDescription ? 180 : 0))
                }
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showDescription.toggle()
                    }
                }
            } else {
                Text(compressDescription())
                    .foregroundColor(Color.gray)
            }
        }
        .padding(.vertical, 8)
    }
    
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
                vm.currentLaunch = nil
                vm.currentLocation = nil
                vm.currentPad = nil
            }
    }
    
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
