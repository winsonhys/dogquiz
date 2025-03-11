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
        
        // Find answer buttons
        let answerButtons = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'Breed:'"))
        XCTAssertGreaterThan(answerButtons.count, 0, "No answer buttons found")
        
        // Select an answer
        let firstAnswer = answerButtons.element(boundBy: 0)
        let answerText = firstAnswer.label
        firstAnswer.tap()
        
        let expectation = XCTestExpectation(description: "Wait for updated button to appear")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.5)
        // Button is updated, question has changed.
        let answerButtons2 = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'Breed:'"))
        XCTAssertGreaterThan(answerButtons.count, 0, "No answer buttons found")
        let secondAnswer = answerButtons.element(boundBy: 0)
        XCTAssertTrue(secondAnswer.label != answerText)
        // TODO: Add image change verification also
        
        
    }
    
    func testCorrectAnswerAnimation() throws {
        // This test would simulate selecting the correct answer
        // and verifying the confetti animation appears
        
        // Note: Testing animations is challenging with XCUITest
        // You might need to check for specific elements that appear
        // during or after the animation, or verify state changes
        
        // Navigate to quiz with known answers (you might need a test mode)
        app.buttons["Test Mode"].tap() // Assumes you have a test mode button
        
        // Select the correct answer (assuming we know which is correct in test mode)
        let correctAnswerButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'Correct Answer'")).element
        XCTAssertTrue(correctAnswerButton.exists, "Correct answer button not found")
        correctAnswerButton.tap()
        
        // Verify animation or its effects
        // Could check for animation container or wait for "Next" button
        let animationComplete = app.buttons["Next"].waitForExistence(timeout: 5)
        XCTAssertTrue(animationComplete, "Animation did not complete")
    }
} 
