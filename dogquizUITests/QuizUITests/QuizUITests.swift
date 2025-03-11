//
//  QuizUITests.swift
//  dogquizUITests
//
//  Created by AI Assistant on 9/3/25.
//

import XCTest

class QuizUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testAnswerButtonInteraction() throws {
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
        let currentScore2 = app.staticTexts["Current Score: 6"].waitForExistence(timeout: 2)
        XCTAssertTrue(currentScore2)
        let questionsLeft2 = app.staticTexts["Questions Left: 1"].waitForExistence(timeout: 2)
        XCTAssertTrue(questionsLeft2)
        
        
        
        // Button is updated, question has changed.
//        let answerButtons2 = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'Breed:'"))
//        XCTAssertGreaterThan(answerButtons.count, 0, "No answer buttons found")
//        let secondAnswer = answerButtons.element(boundBy: 0)
//        XCTAssertTrue(secondAnswer.label != answerText)
        // TODO: Add image change verification also
        
        
    }
    
} 
