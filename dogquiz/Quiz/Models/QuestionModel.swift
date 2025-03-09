//
//  QuestionModel.swift
//  dogquiz
//
//  Created by Winson Heng on 9/3/25.
//
import Foundation
import SwiftUI


struct QuestionModel {
    private let breedService = DogBreedService.shared
    let dogImageUrl: URL
    let correctDogBreed: Breed
    let alternateDogBreedSelections: [Breed]
    
    init(dogImageUrl: URL) {
        self.dogImageUrl = dogImageUrl
        
        let correctDogBreedFromUrl = Utils.getBreedFromImageUrlString(dogImageUrl.absoluteString)
        self.correctDogBreed = correctDogBreedFromUrl
        
        self.alternateDogBreedSelections = breedService.getRandomBreeds(count: 3, excludes: [self.correctDogBreed])
    }
    
    func isCorrectAnswer(selectedBreed: Breed) -> Bool {
        return selectedBreed == correctDogBreed
    }
    
    func getRandomBreedOrder() -> [Breed] {
        var breeds = alternateDogBreedSelections + [correctDogBreed]
        breeds.shuffle()
        return breeds
    }
    
    
    
}
