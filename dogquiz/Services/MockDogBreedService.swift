import Foundation

class MockDogBreedService: DogBreedService {
    
    var initCalled = false

    override func loadAllBreeds() async -> [Breed] {
        return [Breed(mainBreed: "1", subBreed: "1"), Breed(mainBreed: "2", subBreed: "2"), Breed(mainBreed: "3", subBreed: "3"), Breed(mainBreed: "4", subBreed: "4"), Breed(mainBreed: "5", subBreed: "5")]
    }
    




} 
