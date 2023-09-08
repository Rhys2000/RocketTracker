//
//  LaunchPad.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/3/23.
//

import Foundation

struct LaunchPad: Identifiable, Codable {
    
    let shortName: String
    let fullName: String
    let operatorName: String
    let status: OperationalStatus
    let latitude: Double
    let longitude: Double
    
    var id: String { shortName }
    
    func getLaunchPadFullName() -> String {
        return "\(fullName) (\(shortName))"
    }
    
    func convertToNWCoordinates(latitude: Double, longitude: Double) -> String {
        func degreesMinutesSeconds(coordinate: Double, isLatitude: Bool) -> (Int, Int, Double, String) {
            let direction = isLatitude ? (coordinate >= 0 ? "N" : "S") : (coordinate >= 0 ? "E" : "W")
            let absoluteCoordinate = abs(coordinate)
            let degrees = Int(absoluteCoordinate)
            let remainingMinutes = (absoluteCoordinate - Double(degrees)) * 60
            let minutes = Int(remainingMinutes)
            let seconds = (remainingMinutes - Double(minutes)) * 60
            return (degrees, minutes, seconds, direction)
        }

        let (latDegrees, latMinutes, latSeconds, latDirection) = degreesMinutesSeconds(coordinate: latitude, isLatitude: true)
        let (lonDegrees, lonMinutes, lonSeconds, lonDirection) = degreesMinutesSeconds(coordinate: longitude, isLatitude: false)

        let latitudeCoordinate = "\(latDegrees)° \(latMinutes)' \(String(format: "%.0f", latSeconds))\" \(latDirection)"
        let longitudeCoordinate = "\(lonDegrees)° \(lonMinutes)' \(String(format: "%.0f", lonSeconds))\" \(lonDirection)"

        return "\(latitudeCoordinate), \(longitudeCoordinate)"
    }
}
