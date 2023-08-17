//
//  String.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/17/23.
//

import Foundation

extension String {
    private var inputDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "en-US")
        return formatter
    }
    
    private var outputDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMMM d, yyyy h:mm:ss a (zzz)"
        formatter.locale = Locale(identifier: "en-US")
        return formatter
    }
    
    func stringAsADate() -> String {
        let calendar = Calendar.current
        let localComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .timeZone], from: inputDateFormatter.date(from: self)!)
        return outputDateFormatter.string(from: calendar.date(from: localComponents)!)
    }
    
}
