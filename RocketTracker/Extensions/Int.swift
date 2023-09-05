//
//  Int.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/5/23.
//

import Foundation

extension Int {
    
    func addNumberEnding() -> String {
        if self % 100 == 11 || self % 100 == 12 || self % 100 == 13 {
            return "\(self)th"
        }

        switch self % 10 {
        case 1:
            return "\(self)st"
        case 2:
            return "\(self)nd"
        case 3:
            return "\(self)rd"
        default:
            return "\(self)th"
        }
    }
}
