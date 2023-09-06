//
//  PreviewProvider.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/15/23.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DevelopmentPreview {
        return DevelopmentPreview.instance
    }
}

class DevelopmentPreview {
    static let instance = DevelopmentPreview()
    
    private init() { }
    
    let launchVM = LaunchViewModel()
    
    let launch = Launch(cosparCode: "2020-101", missionName: "National Reconnaissance Office Launch - 108", altMissionName: "USA-312 / USA-313", abbrMissionName: "NROL-108", liftOffTime: "2020-12-19T14:00:00+0000", orbitalDestination: .leo, launchProvider: "SpaceX", launchSiteShortName: "Kennedy", launchPadAbbr: "LC-39A", vehicleName: "Falcon 9", vehicleVariant: "Block 5", missionOutcome: .failure, crewedLaunch: "false", staticFireGap: "", boosterData: ["B1059-5"], boosterRecoveryMethod: [.droneship], boosterRecoveryLocation: ["LZ-1"], boosterRecoveryDistance: ["14.75"], boosterRecoveryOutcome: [.success], numberOfFairingFlights: ["1", "3"], fairingRecoveryMethod: [.splashdown, .netCatch], fairingRecoveryLocation: ["Pacific", "Mr. Steven"], fairingRecoveryDistance: "456", fairingRecoveryOutcome: [.success, .partialSuccess], supportVessel: ["Go Ms. Tree", "Go Searcher"], supportVesselRole: [[.dsv], [.dsv]], description: ["On Tuesday, August 18 at 10:31 a.m. EDT, SpaceX launched its eleventh Starlink mission, which included 58 Starlink satellites and three of Planet’s SkySats. Falcon 9 lifted off from Space Launch Complex 40 (SLC-40) at Cape Canaveral Air Force Station in Florida.", "Falcon 9’s first stage previously supported the Telstar 18 VANTAGE mission in September 2018, the Iridium-8 mission in January 2019, and three separate Starlink missions in May 2019, January 2020, and June 2020. Following stage separation, SpaceX landed Falcon 9’s first stage on the “Of Course I Still Love You” droneship, which was stationed in the Atlantic Ocean. Falcon 9’s fairing previously flew on the fourth launch of Starlink and one of SpaceX’s fairing recovery vessels, Ms. Tree, caught a fairing half after launch.", "Planet’s SkySats deployed sequentially about 12 and a half minutes after liftoff, and the Starlink satellites deployed approximately 46 minutes after liftoff."], livestreamLink: "https://www.youtube.com/watch?v=9OeVwaFBkfE")
    
    let launchSiteVM = LaunchSiteViewModel()
    
    let launchSite = LaunchSite(shortName: "Starbase", fullName: "SpaceX South Texas Launch Site", abbrName: "SBTX", previousNames: ["Boca Chica"], owner: "SpaceX", status: .active, latitude: 13.45, longitude: 3.23, territory: "Virginia", country: "United Kingdom", abbrTimezone: "GMT", launchPads: [LaunchPad(shortName: "SP-A", fullName: "Suborbital Pad - A", latitude: 5.67, longitude: -2.93)])
    
    let booster = Booster(name: "B1059", method: .droneship, location: "LZ-1", distance: "14.75", outcome: .success, flightNumber: 5)
    
    let fairings = [Fairing(flightNumber: 1, method: .netCatch, location: "Mr. Steven", distance: "456", outcome: .partialSuccess), Fairing(flightNumber: 3, method: .splashdown, location: "Pacific", distance: "456", outcome: .success)]
}
