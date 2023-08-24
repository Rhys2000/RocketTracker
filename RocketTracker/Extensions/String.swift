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
    
    var isCapitalLetter: Bool {
        let letterCharacters = CharacterSet.uppercaseLetters
        return CharacterSet(charactersIn: self).isSubset(of: letterCharacters)
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
    
    func stringAsADate() -> String {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.locale = Locale(identifier: "en-US") //Change the locale to be user specific
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "E, MMMM d, yyyy h:mm:ss a (zzz)"
        outputFormatter.locale = Locale(identifier: "en-US") //Change the locale to be user specific
        
        let calendar = Calendar.current
        
        let localComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .timeZone], from: inputFormatter.date(from: self)!)
        
        return outputFormatter.string(from: calendar.date(from: localComponents)!)
    }
    
}
