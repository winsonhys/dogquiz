import XCTest
@testable import dogquiz

final class QuestionModelTests: XCTestCase {
    
    func testGetBreedFromImageUrl_WithValidSingleBreed() {
        // Arrange
        let sut = QuestionModel(dogImageUrl: "", correctDogBreed: "", dogBreedSelections: [])
        let url = "https://example.com/api/breeds/hound/images/random.jpg"
        
        // Act
        let result = sut.getBreedFromImageUrl(url)
        
        // Assert
        XCTAssertEqual(result, "hound")
    }
    
    func testGetBreedFromImageUrl_WithValidCompoundBreed() {
        // Arrange
        let sut = QuestionModel(dogImageUrl: "", correctDogBreed: "", dogBreedSelections: [])
        let url = "https://example.com/api/breeds/hound-afghan/images/random.jpg"
        
        // Act
        let result = sut.getBreedFromImageUrl(url)
        
        // Assert
        XCTAssertEqual(result, "hound-afghan")
    }
    
    func testGetBreedFromImageUrl_WithNoBreedSegment() {
        // Arrange
        let sut = QuestionModel(dogImageUrl: "", correctDogBreed: "", dogBreedSelections: [])
        let url = "https://example.com/api/dogs/images/random.jpg"
        
        // Act
        let result = sut.getBreedFromImageUrl(url)
        
        // Assert
        XCTAssertEqual(result, "")
    }
    
    func testGetBreedFromImageUrl_WithEmptyBreedSegment() {
        // Arrange
        let sut = QuestionModel(dogImageUrl: "", correctDogBreed: "", dogBreedSelections: [])
        let url = "https://example.com/api/breeds//images/random.jpg"
        
        // Act
        let result = sut.getBreedFromImageUrl(url)
        
        // Assert
        XCTAssertEqual(result, "")
    }
    
    func testGetBreedFromImageUrl_WithMalformedUrl() {
        // Arrange
        let sut = QuestionModel(dogImageUrl: "", correctDogBreed: "", dogBreedSelections: [])
        let url = ""
        
        // Act
        let result = sut.getBreedFromImageUrl(url)
        
        // Assert
        XCTAssertEqual(result, "")
    }
} 