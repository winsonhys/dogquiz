//
//  QuestionModel.swift
//  dogquiz
//
//  Created by Winson Heng on 9/3/25.
//
import Foundation
import SwiftUI
import Dependencies
import uuid

struct QuestionModel: Identifiable {
    var id = UUID().uuidString
    

    @Dependency(DogBreedService.self) var breedService
    
    let dogImageUrl: URL
    let correctDogBreed: Breed
    private(set) var  alternateDogBreedSelections: [Breed] = []
    private(set) var  randomBreedOrder: [Breed] = []
    
    init(dogImageUrl: URL) {
        self.dogImageUrl = dogImageUrl
        
        let correctDogBreedFromUrl = Utils.getBreedFromImageUrlString(dogImageUrl.absoluteString)
        self.correctDogBreed = correctDogBreedFromUrl
        self.alternateDogBreedSelections = breedService.getRandomBreeds(count: 3, excludes: [correctDogBreedFromUrl])
        
        self.randomBreedOrder = (alternateDogBreedSelections + [correctDogBreed]).shuffled()
    }
    
    func isCorrectAnswer(selectedBreed: Breed) -> Bool {
        return selectedBreed == correctDogBreed
    }
    
    
    
    
}
