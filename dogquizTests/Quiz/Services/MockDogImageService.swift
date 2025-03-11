import Foundation
@testable import dogquiz

final class MockDogImageService: DogImageService {
    var mockImages: [String] = []
    override func loadMultipleImages(count: Int) async -> [String] {
        <#code#>
    }
    

} 
