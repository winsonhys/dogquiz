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
    
    private init(){}
       
    private let client = NetworkClient.shared.client
    
    func getRandomBreeds(count: Int, excludes: [Breed]) -> [Breed] {
        guard !_allBreeds.isEmpty else {fatalError("Please call initBreeds() before calling this function")}
        var randomBreeds: Set<Breed> = Set()
        let excludeSet = Set(excludes)
        while randomBreeds.count < count {
            // This will never be nil.
            let randomBreed = _allBreeds.randomElement()!
            // Ensure that there are no repeated selections
            if excludeSet.contains(randomBreed) || randomBreeds.contains(randomBreed) {
               continue
            }
            randomBreeds.insert(randomBreed)
            
        }
        return Array(randomBreeds)
        
        
    }
    
    func initBreeds() async {
        if _allBreeds.count > 0 {
            return
        }
        _allBreeds = await loadAllBreeds()
    }
    
    private func loadAllBreeds() async -> [Breed] {
        
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
