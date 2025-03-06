import Foundation
import Moya

class DogService {
    private let provider: MoyaProvider<DogAPI>
    
    init(provider: MoyaProvider<DogAPI> = MoyaProvider<DogAPI>()) {
        self.provider = provider
    }
    
    func fetchAllBreeds() async throws -> BreedsResponse {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.getAllBreeds) { result in
                switch result {
                case .success(let response):
                    do {
                        let breedsResponse = try response.map(BreedsResponse.self)
                        continuation.resume(returning: breedsResponse)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func fetchRandomImages(count: Int = 3) async throws -> RandomImagesResponse {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.getRandomImages(count: count)) { result in
                switch result {
                case .success(let response):
                    do {
                        let imagesResponse = try response.map(RandomImagesResponse.self)
                        continuation.resume(returning: imagesResponse)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
} 