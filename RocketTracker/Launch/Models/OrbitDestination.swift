//
//  OrbitDestination.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/3/23.
//

import Foundation

enum OrbitDestination: String, Codable {
    case leo = "LEO"
    case pleo = "PLEO"
    case plro = "PLRO"
    case meo = "MEO"
    case geo = "GEO"
    case gto = "GTO"
    case iss = "ISS"
    case sso = "SSO"
    case heo = "HEO"
    case helo = "HELO"
    case sub = "SUB"
    case tli = "TLI"
    case sel1 = "SEL1"
    case sel2 = "SEL2"
    case helio = "HELIO"
    case notAvailable = "NA"
    
    func getFullName() -> String {
        switch self {
        case .leo:
            return "Low Earth Orbit"
        case .pleo:
            return "Polar Low Earth Orbit"
        case .plro:
            return "Polar Orbit"
        case .meo:
            return "Medium Earth Orbit"
        case .geo:
            return "Geostationary Equatorial Orbit"
        case .gto:
            return "Geostationary Transfer Orbit"
        case .iss:
            return "International Space Station"
        case .sso:
            return "Sun Synchronous Orbit"
        case .heo:
            return "High Earth Orbit"
        case .helo:
            return "Highly Elliptical Orbit"
        case .sub:
            return "Suborbital Trajectory"
        case .tli:
            return "Trans-Lunar Injection Orbit"
        case .sel1:
            return "Sun-Earth Lagrange Point 1"
        case .sel2:
            return "Sun-Earth Lagrange Point 2"
        case .helio:
            return "Heliocentric Orbit"
        case .notAvailable:
            return "Not Available"
        }
    }
}
