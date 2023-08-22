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
    
    let launch = Launch(id: "2020-101", missionName: "National Reconnaisance Office Launch - 108", alternativeMissionName: "USA-321 / USA-313", abbreviatedMissionName: "NROL-108", liftOffTime: "2020-12-19T14:00:00+0000", orbitalDestination: .leo, launchProvider: .spacex, launchSiteName: "Kennedy", launchSitePad: "LC-39A", vehicleName: "Falcon 9", vehicleVariant: "Block 5", missionOutcome: .failure, crewedLaunch: "false", staticFire: "false", staticFireToLaunchWindow: "0", boosterName: ["B1059-5"], boosterRecoveryAttempted: ["true"], boosterRecoveryMethod: [.droneship], boosterRecoveryLocation: ["LZ-1"], boosterRecoveryDistance: ["14.75"], boosterRecoveryOutcome: [.success], numberOfFairingFlights: ["1", "1"], fairingRecoveryAttempted: ["true", "true"], fairingRecoveryMethod: [.splashdown, .splashdown], fairingRecoveryLocation: ["Atlantic", "Atlantic"], fairingRecoveryDistance: "328", fairingRecoveryOutcome: [.success, .success], supportVessel: ["Go Ms. Tree", "Go Searcher"], supportVesselRole: [[.dsv], [.dsv]], description: ["SpaceX is targeting Thursday, December 17 for the launch of the NROL-108 mission, which will launch from Launch Complex 39A (LC-39A) at Kennedy Space Center, Florida."], livestreamLink: "https://www.youtube.com/watch?v=9OeVwaFBkfE")
}
