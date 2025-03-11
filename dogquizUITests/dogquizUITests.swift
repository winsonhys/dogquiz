//
//  QuizUITests.swift
//  dogquizUITests
//
//  Created by AI Assistant on 9/3/25.
//

import XCTest
import Dependencies

class DogQuizUITests: XCTestCase {
    
    let app: XCUIApplication = XCUIApplication()
    
    
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app.launch()
    }
    
    func testFullInteractionFullMarks() throws {
        // Navigate to quiz screen
        // Note: You'll need to modify this to match your app's navigation flow
        app.buttons["Start"].tap()
        
        // Wait for the question to appear
        let questionExists = app.staticTexts["What is the correct breed?"].waitForExistence(timeout: 2)
        XCTAssertTrue(questionExists)
        
        
        for i in 0..<12 {
            // Find answer buttons
            let answerButtons = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'Breed: hound'"))
            
            // Select correct answer
            let firstAnswer = answerButtons.element(boundBy: 0)
            let answerText = firstAnswer.label
            firstAnswer.tap()
            
            let expectation = XCTestExpectation(description: "Wait for updated button to appear")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 3.5)
        }
        
        
        
        
        
        
        let scoreSaved = app.staticTexts["Score: \(12)"].waitForExistence(timeout: 2)
        XCTAssertTrue(scoreSaved)
        
        let noFullMarks = app.staticTexts["Good luck on obtaining full marks!"].waitForExistence(timeout: 2)
        XCTAssertFalse(noFullMarks)
        
        
        
    }
    
    func testFullInteractionNotFullMarks() throws {
        // Navigate to quiz screen
        // Note: You'll need to modify this to match your app's navigation flow
        app.buttons["Start"].tap()
        
        // Wait for the question to appear
        let questionExists = app.staticTexts["What is the correct breed?"].waitForExistence(timeout: 2)
        XCTAssertTrue(questionExists)
        
        
        for i in 0..<6 {
            // Find answer buttons
            let answerButtons = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'Breed: hound'"))
            
            // Select correct answer
            let firstAnswer = answerButtons.element(boundBy: 0)
            let answerText = firstAnswer.label
            firstAnswer.tap()
            
            let expectation = XCTestExpectation(description: "Wait for updated button to appear")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 3.5)
        }
        
        let currentScore = app.staticTexts["Current Score: 6"].waitForExistence(timeout: 2)
        XCTAssertTrue(currentScore)
        let questionsLeft = app.staticTexts["Questions Left: 6"].waitForExistence(timeout: 2)
        XCTAssertTrue(questionsLeft)
        // All Wrong selections
        for i in 0..<5 {
            // Find answer buttons
            let answerButtons = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'Breed:' AND NOT (label CONTAINS[c] 'hound')"))
            
            // Select wrong
            let firstAnswer = answerButtons.element(boundBy: 0)
            let answerText = firstAnswer.label
            firstAnswer.tap()
            
            let expectation = XCTestExpectation(description: "Wait for updated button to appear")
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 3.5)
        }
        let currentScore2 = app.staticTexts["Current Score: 6"].waitForExistence(timeout: 2)
        XCTAssertTrue(currentScore2)
        let questionsLeft2 = app.staticTexts["Questions Left: 1"].waitForExistence(timeout: 2)
        XCTAssertTrue(questionsLeft2)
        
        let answerButtons = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'Breed:' AND NOT (label CONTAINS[c] 'hound')"))
        
        // Select wrong
        let firstAnswer = answerButtons.element(boundBy: 0)
        let answerText = firstAnswer.label
        firstAnswer.tap()
        
        
        
        let scoreSaved = app.staticTexts["Score: \(6)"].waitForExistence(timeout: 2)
        XCTAssertTrue(scoreSaved)
        
        let noFullMarks = app.staticTexts["Good luck on obtaining full marks!"].waitForExistence(timeout: 2)
        
        
        
    }
    
}
