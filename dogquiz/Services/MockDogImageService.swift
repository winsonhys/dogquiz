import Foundation

class MockDogImageService: DogImageService {
    static let mockUrl = "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg"
    
    override func loadMultipleImages(count: Int) async -> [String] {
            
        return (0..<count).map { _ in
            return MockDogImageService.mockUrl
        }
    }
    

} 
