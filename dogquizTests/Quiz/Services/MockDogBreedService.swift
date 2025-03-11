import Foundation
@testable import dogquiz

class MockDogBreedService: DogBreedService {
    var mockBreeds: [Breed] = []
    var initCalled = false

    override func loadAllBreeds() async -> [dogquiz.Breed] {
        <#code#>
    }
    



    override func initBreeds() async {
        initCalled = true
    }
} 
