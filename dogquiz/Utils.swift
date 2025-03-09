//
//  Utils.swift
//  dogquiz
//
//  Created by Winson Heng on 9/3/25.
//

class Utils {
    static func getBreedFromImageUrlString(_ url: String) -> Breed {
        let components = url.components(separatedBy: "/breeds/")
        guard components.count > 1 else { return Breed() }
        
        let breedPath = components[1]
        let breedComponents = breedPath.components(separatedBy: "/")
        guard breedComponents.count > 0 else { return Breed() }
        
        return Breed(mainBreed: breedComponents[0])
    }
    
}
