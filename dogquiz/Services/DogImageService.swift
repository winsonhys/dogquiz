//
//  DogImageService.swift
//  dogquiz
//
//  Created by Winson Heng on 9/3/25.
//

import Foundation



class DogImageService {
    
    private init() {
    }
    static let shared = DogImageService()
    
    private let client = NetworkClient.shared.client
    
    func loadMultipleImages(count: Int) async -> [String] {
        
        do {
            let response = try await client.getMultipleRandomImages(.init(path: .init(count: count)))
            switch response {
                case .ok(let okResponse):
                    switch okResponse.body {
                        case .json(let dogImages):
                        return dogImages.message
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
}

