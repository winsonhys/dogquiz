//
//  QuestionModel.swift
//  dogquiz
//
//  Created by Winson Heng on 9/3/25.
//
import Foundation
import SwiftUI


struct QuestionModel {
    let dogImageUrl: String
    let correctDogBreed: Breed
    let alternateDogBreedSelections: [Breed]
    
    init(dogImageUrl: String, alternateDogBreedSelections: [Breed]) {
        self.dogImageUrl = dogImageUrl
        let correctDogBreedFromUrl = QuestionModel.getBreedFromImageUrl(dogImageUrl)
        
        self.correctDogBreed = correctDogBreedFromUrl
        self.alternateDogBreedSelections = alternateDogBreedSelections
    }
    
    func isCorrectAnswer(selectedBreed: Breed) -> Bool {
        return selectedBreed == correctDogBreed
    }
    
    static func getBreedFromImageUrl(_ url: String) -> Breed {
        let components = url.components(separatedBy: "/breeds/")
        guard components.count > 1 else { return Breed() }
        
        let breedPath = components[1]
        let breedComponents = breedPath.components(separatedBy: "/")
        guard breedComponents.count > 0 else { return Breed() }
        
        return Breed(mainBreed: breedComponents[0])
    }
    
}
