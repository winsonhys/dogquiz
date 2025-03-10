//
//  Utils.swift
//  dogquiz
//
//  Created by Winson Heng on 9/3/25.
//
import SwiftUI
class Utils {
    static func getBreedFromImageUrlString(_ url: String) -> Breed {
        let components = url.components(separatedBy: "/breeds/")
        guard components.count > 1 else { return Breed() }
        
        let breedPath = components[1]
        let breedComponents = breedPath.components(separatedBy: "/")
        guard breedComponents.count > 0 else { return Breed() }
        
        let breedString = breedComponents[0]
        
        // Check if the breed string contains a hyphen (indicating a subbreed)
        if breedString.contains("-") {
            let breedParts = breedString.components(separatedBy: "-")
            return Breed(mainBreed: breedParts[0], subBreed: breedParts[1])
        } else {
            return Breed(mainBreed: breedString)
        }
    }
    static let backgroundColor = Color.init(hex: "#f9f3d9")
    
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255
        let green = Double((rgb >> 8) & 0xFF) / 255
        let blue = Double(rgb & 0xFF) / 255
        self.init(red: red, green: green, blue: blue)
    }
}


