//
//  QuizModel.swift
//  dogquiz
//
//  Created by Winson Heng on 9/3/25.
//
import Foundation
import SwiftUI
import Collections

@Observable
class QuizModel {
    private let kMaxQuestions = 10
    private let client = NetworkClient.shared.client
    
    private var questionQueue = Deque<QuestionModel>()
    private let breedService = DogBreedService.shared
    private let imageService = DogImageService.shared
    
    
    
    func getNextQuestion() -> QuestionModel? {
        return questionQueue.first
    }
    
    func loadQuestions() async {
        let dogImageUrls = await loadMultipleImages()
        dogImageUrls.forEach { url in
            questionQueue.append(QuestionModel(dogImageUrl: url, alternateDogBreedSelections: []))
        }
        
    }
    func loadMultipleImages() async -> [String] {
        if kMaxQuestions - questionQueue.count == 0 {
            return []
        }
        return await imageService.loadMultipleImages(count: kMaxQuestions - questionQueue.count)
    }
    
    
    
//    func
}
