//
//  ImageTabView.swift
//  RocketTracker
//
//  Created by Rhys Julian-Jones on 9/1/23.
//

import SwiftUI

struct ImageTabView: View {
    
    let height: CGFloat
    let vehicleName: String
    
    var body: some View {
        TabView {
            let imageNames = generateUniqueRandomNumbers()
            ForEach(imageNames, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: height)
        .tabViewStyle(PageTabViewStyle())
    }
    
    func generateUniqueRandomNumbers() -> [String] {
        
        var randomNumbers = Set<String>()
        
        while randomNumbers.count < 4 {
            let randomNumber = Int.random(in: 1...20)
            randomNumbers.insert("\(vehicleName)-\(randomNumber)".replacingOccurrences(of: " ", with: ""))
        }
        return Array(randomNumbers)
    }
}

struct ImageTabView_Previews: PreviewProvider {
    static var previews: some View {
        ImageTabView(height: 300, vehicleName: "Falcon 9")
    }
}
