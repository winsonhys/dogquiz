import XCTest
@testable import dogquiz

final class QuestionModelTests: XCTestCase {
    
    func testQuestionCreation() {
        // Given
        let imageUrl = URL(string: "https://example.com/dog.jpg")!
        
        // When
        let question = QuestionModel(dogImageUrl: imageUrl)
        
        // Then
        XCTAssertEqual(question.dogImageUrl, imageUrl)
        XCTAssertEqual(question.options.count, 4) // Assuming 4 options per question
        
        // Verify one option is correct
        let correctOptions = question.options.filter { $0.isCorrect }
        XCTAssertEqual(correctOptions.count, 1)
    }
    
    func testOptionSelection() {
        // Given
        let imageUrl = URL(string: "https://example.com/dog.jpg")!
        let question = QuestionModel(dogImageUrl: imageUrl)
        
        // When & Then
        if let correctOption = question.options.first(where: { $0.isCorrect }) {
            XCTAssertTrue(question.checkAnswer(option: correctOption.id))
        } else {
            XCTFail("No correct option found")
        }
        
        if let incorrectOption = question.options.first(where: { !$0.isCorrect }) {
            XCTAssertFalse(question.checkAnswer(option: incorrectOption.id))
        } else {
            XCTFail("No incorrect option found")
        }
    }
    
    func testOptionGeneration() {
        // Given
        let imageUrl = URL(string: "https://example.com/dog.jpg")!
        
        // When
        let question1 = QuestionModel(dogImageUrl: imageUrl)
        let question2 = QuestionModel(dogImageUrl: imageUrl)
        
        // Then
        // Verify the options include the correct breed for the image
        XCTAssertTrue(question1.options.contains(where: { $0.isCorrect }))
        
        // This test can be expanded based on how options are actually generated
        // For example, if we have access to the actual breed name from the URL
    }
} 