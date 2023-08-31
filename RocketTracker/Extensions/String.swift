//
//  String.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 8/17/23.
//

import Foundation

extension String {
    
    var isDigit: Bool {
        let digitCharactres = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitCharactres)
    }
    
    var isBool: Bool {
        return Bool(self)!
    }
    
    var isCapitalLetter: Bool {
        let letterCharacters = CharacterSet.uppercaseLetters
        return CharacterSet(charactersIn: self).isSubset(of: letterCharacters)
    }
    
    var isAlphaNumericDash: Bool {
        let alphaNumericDashCharcaters = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-")
        return CharacterSet(charactersIn: self).isSubset(of: alphaNumericDashCharcaters)
    }
    
    func isBetween(_ startingValue: Int, _ endingValue: Int) -> Bool {
        return (Int(self)! >= startingValue && Int(self)! <= endingValue)
    }
    
    func isEqual(_ string: String) -> Bool {
        return self == string
    }
    
    func subString(from: Int, to: Int) -> String {
        let startingIndex = self.index(self.startIndex, offsetBy: from)
        let endingIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startingIndex..<endingIndex])
    }
    
    func statusTime(timezone: TimeZone) -> String {
        
        let calendar = Calendar.current
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = timezone
        
        let localComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .timeZone], from: dateFormatter.date(from: self)!)
        
        dateFormatter.dateFormat = "E, MMMM d, yyyy h:mm:ss a (zzz)"
        
        return dateFormatter.string(from: calendar.date(from: localComponents)!)
    }
    
}
