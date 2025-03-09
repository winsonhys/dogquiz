//
//  QuizModel.swift
//  dogquiz
//
//  Created by Winson Heng on 9/3/25.
//
import Foundation
import SwiftUI
import Collections
import Kingfisher

@Observable
class QuizModel {
    private let kMaxQuestionsCacheCount = 10
    private let client = NetworkClient.shared.client
    
    private var questionQueue = Deque<QuestionModel>()
    private let breedService = DogBreedService.shared
    private let imageService = DogImageService.shared
    
    func load() async {
        (_, _) = await (breedService.initBreeds(), loadQuestions())
    }
    
    
    
    func getNextQuestion() -> QuestionModel? {
        return questionQueue.popFirst()
    }
    
    func loadQuestions() async {
        if kMaxQuestionsCacheCount - questionQueue.count == 0 {
            return
        }
        let dogImageUrlStrings = await imageService.loadMultipleImages(count: kMaxQuestionsCacheCount - questionQueue.count)
        let dogImageUrls = dogImageUrlStrings.compactMap { URL(string: $0) }
        dogImageUrls.forEach { url in
            questionQueue.append(QuestionModel(dogImageUrl: url))
        }
        
        ImagePrefetcher(urls: dogImageUrls).start()
        
    }
//    func
}
