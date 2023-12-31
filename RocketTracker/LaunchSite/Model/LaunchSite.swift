//
//  LaunchSite.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/14/23.
//

import Foundation
import MapKit

/*
 JSON Format
 {
     "shortName" : "",
     "fullName" : "",
     "abbrName" : "",
     "previousNames" : [""],
     "latitude" : ,
     "longitude" : ,
     "territory" : "",
     "country" : "",
     "launchPads" : [
         {
              "shortName" : "",
              "fullName" : "",
              "latitude" : ,
              "longitude" : ,
         }
     ]
 },
 */

struct LaunchSite: Identifiable, Codable {
    
    let shortName: String
    let fullName: String
    let abbrName: String
    let previousNames: [String]
    let owner: String
    let status: OperationalStatus
    let latitude: Double
    let longitude: Double
    let territory: String
    let country: String
    let abbrTimezone: String
    let launchPads: [LaunchPad]
    
    var id: String { shortName }
    
    var timezone: TimeZone {
        TimeZone(abbreviation: abbrTimezone)!
    }
    
    func getLaunchSiteAndLaunchPadFullName(_ launchPad: LaunchPad) -> String {
        var tempString = ""
        
        tempString += launchPad.getLaunchPadFullName()
        tempString += ", \(fullName) (\(abbrName)), \(territory), \(country)"
        return tempString
    }
    
    func getCountryFlag() -> String {
        switch country {
        case "United States":
            return "🇺🇸"
        default:
            return ""
        }
    }
}
