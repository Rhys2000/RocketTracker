//
//  Date.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/31/23.
//

import Foundation

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
