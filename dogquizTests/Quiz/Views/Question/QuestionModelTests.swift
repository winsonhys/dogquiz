import XCTest
@testable import dogquiz

final class QuestionModelTests: XCTestCase {
    
    func testQuestionCreation() {
        // Given
        let imageUrl = URL(string: MockDogImageService.mockUrl)!
        
        // When
        let question = QuestionModel(dogImageUrl: imageUrl)
        
        // Then
        XCTAssertEqual(question.dogImageUrl, imageUrl)
        XCTAssertEqual(question.randomBreedOrder.count, 4) // Assuming 4 options per question
        
        // Verify one option is correct
        let correctOptions = question.randomBreedOrder.filter { question.isCorrectAnswer(selectedBreed: $0) }
        XCTAssertEqual(correctOptions.count, 1)
    }
    
    
} 
