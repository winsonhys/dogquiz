//
//  DogBreedService.swift
//  dogquiz
//
//  Created by Winson Heng on 9/3/25.
//

import Foundation

class DogBreedService {
    static let shared = DogBreedService()
    var _allBreeds: [Breed] = []
    var allBreeds: [Breed] {
        return _allBreeds
    }
    private init(){}
       
    private let client = NetworkClient.shared.client
    
    func loadAllBreeds() async -> [Breed] {
        
        do {
            let response = try await client.listAllBreeds()
            switch response {
                case .ok(let okResponse):
                    switch okResponse.body {
                        case .json(let allBreeds):
                        return parseAllBreeds(res: allBreeds.message)
                    }
                
            case .undocumented(statusCode: let statusCode, _):
                // TODO: Error handling, maybe reinsert some existing question.
                return []
            }
        } catch let err {
            // TODO: Error handling
            return []
        }
    }
    func parseAllBreeds(res: Components.Schemas.BreedListResponse.MessagePayload) -> [Breed] {
        return res.additionalProperties.map { breedSubBreed in
            let breed = breedSubBreed.key
            let uniqueBreeds = breedSubBreed.value.map { subBreed in
                return Breed(mainBreed: breed, subBreed: subBreed)
            }
            return uniqueBreeds
            
        }.flatMap { $0 }
    }
}
