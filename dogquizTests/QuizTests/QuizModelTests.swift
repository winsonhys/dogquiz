import XCTest
@testable import dogquiz

final class QuizModelTests: XCTestCase {
    
    var model: QuizModel!
    var mockImageService: MockDogImageService!
    var mockBreedService: MockDogBreedService!
    
    override func setUp() {
        super.setUp()
        mockImageService = MockDogImageService()
        mockBreedService = MockDogBreedService()
        model = QuizModel()
        // Inject mock services here if needed
    }
    
    override func tearDown() {
        model = nil
        mockImageService = nil
        mockBreedService = nil
        super.tearDown()
    }
    
    func testLoadQuestions() async {
        // Given
        let expectedCount = 10 // kMaxQuestionsCacheCount
        mockImageService.mockImageUrls = Array(repeating: "https://example.com/dog.jpg", count: expectedCount)
        
        // When
        await model.loadQuestions()
        
        // Then
        // We need to access the private questionQueue, so we'll need to either make it testable
        // or add a method to get the queue count for testing
        // XCTAssertEqual(model.getQuestionQueueCount(), expectedCount)
    }
    
    func testGetNextQuestion() async {
        // Given
        mockImageService.mockImageUrls = ["https://example.com/dog1.jpg", "https://example.com/dog2.jpg"]
        await model.loadQuestions()
        
        // When
        let question1 = model.getNextQuestion()
        let question2 = model.getNextQuestion()
        let question3 = model.getNextQuestion()
        
        // Then
        XCTAssertNotNil(question1)
        XCTAssertNotNil(question2)
        XCTAssertNil(question3) // Should be nil after emptying the queue
    }
    
    func testAutoLoadQuestionsWhenRunningLow() async {
        // Given
        mockImageService.mockImageUrls = Array(repeating: "https://example.com/dog.jpg", count: 6)
        await model.loadQuestions() // Load initial questions
        
        // When
        // Pop 2 questions to get below the threshold (5)
        _ = model.getNextQuestion()
        _ = model.getNextQuestion()
        
        // Then
        // Verify that loadQuestions was called again (requires modifying the model for testability)
        // XCTAssertTrue(mockImageService.loadMultipleImagesCalled)
    }
}

