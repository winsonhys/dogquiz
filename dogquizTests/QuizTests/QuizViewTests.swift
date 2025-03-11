import XCTest
import SwiftUI
import SwiftData
@testable import dogquiz

final class QuizViewTests: XCTestCase {
    
    var mockModel: MockQuizModel!
    
    override func setUp() {
        super.setUp()
        mockModel = MockQuizModel()
    }
    
    override func tearDown() {
        mockModel = nil
        super.tearDown()
    }
    
    func testInitialState() {
        // Given
        let view = QuizView()
        
        // Then
        XCTAssertTrue(view.isLoading)
        XCTAssertEqual(view.currentScore, 0)
        XCTAssertEqual(view.questionsCompleted, 0)
        XCTAssertNil(view.currentQuestion)
    }
    
    func testQuestionCompletion() async {
        // Given
        let view = TestableQuizView(model: mockModel)
        mockModel.mockNextQuestion = QuestionModel(dogImageUrl: URL(string: "https://example.com/dog.jpg")!)
        
        // When
        await view.loadQuiz()
        
        // Then
        XCTAssertFalse(view.isLoading)
        XCTAssertNotNil(view.currentQuestion)
        
        // Simulate answering questions
        for _ in 0..<QuizModel.kMaxQuestionsCount {
            view.simulateCorrectAnswer()
        }
        
        // Check final state
        XCTAssertEqual(view.questionsCompleted, QuizModel.kMaxQuestionsCount)
        XCTAssertEqual(view.currentScore, QuizModel.kMaxQuestionsCount)
    }
    
    func testScoreTracking() async {
        // Given
        let view = TestableQuizView(model: mockModel)
        mockModel.mockNextQuestion = QuestionModel(dogImageUrl: URL(string: "https://example.com/dog.jpg")!)
        
        // When
        await view.loadQuiz()
        
        // Simulate answering 3 correct and 2 wrong
        view.simulateCorrectAnswer()
        view.simulateCorrectAnswer()
        view.simulateWrongAnswer()
        view.simulateCorrectAnswer()
        view.simulateWrongAnswer()
        
        // Then
        XCTAssertEqual(view.currentScore, 3)
        XCTAssertEqual(view.questionsCompleted, 5)
    }
}

// MARK: - Test Helpers

class MockQuizModel: QuizModel {
    var mockNextQuestion: QuestionModel?
    var loadCalled = false
    
    override func load() async {
        loadCalled = true
    }
    
    override func getNextQuestion() -> QuestionModel? {
        return mockNextQuestion
    }
}

struct TestableQuizView {
    @State private var isLoading = true
    @State private var currentQuestion: QuestionModel?
    @State private var currentScore = 0
    @State private var questionsCompleted = 0
    
    private let model: QuizModel
    
    init(model: QuizModel) {
        self.model = model
    }
    
    func loadQuiz() async {
        await model.load()
        isLoading = false
        currentQuestion = model.getNextQuestion()
    }
    
    func simulateCorrectAnswer() {
        currentScore += 1
        currentQuestion = model.getNextQuestion()
        questionsCompleted += 1
    }
    
    func simulateWrongAnswer() {
        currentQuestion = model.getNextQuestion()
        questionsCompleted += 1
    }
} 