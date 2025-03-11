import XCTest
@testable import dogquiz

final class QuizModelTests: XCTestCase {
    
    var model: QuizModel!
    
    override func setUp() {
        super.setUp()
        model = QuizModel()
        Task {
            await model.breedService.initBreeds()
        }
        
        
        // Inject mock services here if needed
    }
    
    override func tearDown() {
        model = nil
        
        super.tearDown()
    }
    
    func testLoadQuestions() async {
        // Given
        let expectedCount = 10 // kMaxQuestionsCacheCount
        
        // When
        await model.loadQuestions()
        
        // Then
        // We need to access the private questionQueue, so we'll need to either make it testable
        // or add a method to get the queue count for testing
        XCTAssertEqual(model.questionQueue.count, expectedCount)
    }
    
    // To test if we have enough questions.
    func testGetNextQuestion() async {
        // Given
//        mockImageService.mockImageUrls = ["https://example.com/dog1.jpg", "https://example.com/dog2.jpg"]
        await model.loadQuestions()
        
        // When
        for i in 0...QuizModel.kMaxQuestionsCount+1 {
            let question = model.getNextQuestion()
            // Since we are using a mock service, this will never be flaky.
            let expectation = XCTestExpectation(description: "Wait for potential questions to load")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                expectation.fulfill()
            }
            XCTAssertNotNil(question)
        }
        
        
    }
}

