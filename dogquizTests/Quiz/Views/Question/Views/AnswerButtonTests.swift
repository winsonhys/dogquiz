//
//  AnswerButtonTests.swift
//  dogquizTests
//
//

import XCTest
import SwiftUI
import ViewInspector
@testable import dogquiz


class AnswerButtonTests: XCTestCase {
    
    func testButtonInitialState() throws {
        // Given
        let breed = Breed(mainBreed: "Labrador", subBreed: "")
        
        // When
        let button = AnswerButton(
            breed: breed,
            hasSelectedAnswer: false,
            isCorrectAnswer: true,
            onTap: {  },
            onAnimationEnd: {  }
        )
        
        // Then
        let text = try button.inspect().find(text: "Breed: Labrador")
        XCTAssertNotNil(text)
        
        
        
        // Test button is blue when not selected
        let buttonView = try button.inspect().find(ViewType.Button.self)
        
        XCTAssertEqual(try buttonView.tint(), Color.blue)
        
        // Test button is enabled
        XCTAssertTrue(buttonView.allowsHitTesting())
    }
    
    func testButtonWithSubBreed() throws {
        // Given
        let breed = Breed(mainBreed: "Poodle", subBreed: "Toy")
        
        // When
        let button = AnswerButton(
            breed: breed,
            hasSelectedAnswer: false,
            isCorrectAnswer: true,
            onTap: { },
            onAnimationEnd: { }
        )
        var text = "Breed: \(breed.mainBreed)\r\n\r\nSub breed: \(breed.subBreed)"
        
        let buttonText = try button.inspect().find(text: text)
        XCTAssertNotNil(buttonText)
        
    }
    
    func testButtonSelectedCorrectAnswer() throws {
        // Given
        let breed = Breed(mainBreed: "Bulldog", subBreed: "")
        
        // When
        let button = AnswerButton(
            breed: breed,
            hasSelectedAnswer: true,
            isCorrectAnswer: true,
            onTap: { },
            onAnimationEnd: { }
        )
        
        // Then
        let buttonView = try button.inspect().find(ViewType.Button.self)
        
        // Test button is green for correct answer
        XCTAssertEqual(try buttonView.tint(), Color.green)
        
        // Test button is disabled after selection
        XCTAssertFalse(buttonView.allowsHitTesting())
    }
    
    func testButtonSelectedIncorrectAnswer() throws {
        // Given
        let breed = Breed(mainBreed: "Beagle", subBreed: "")
        
        // When
        let button = AnswerButton(
            breed: breed,
            hasSelectedAnswer: true,
            isCorrectAnswer: false,
            onTap: { },
            onAnimationEnd: { }
        )
        
        // Then
        let buttonView = try button.inspect().find(ViewType.Button.self)
        
        
        // Test button is red for incorrect answer
        XCTAssertEqual(try buttonView.tint(), Color.red)
        
        // Test button is disabled after selection
        XCTAssertFalse(buttonView.allowsHitTesting())
    }
    
    func testButtonTapTriggersCallback() throws {
        // Given
        let breed = Breed(mainBreed: "Golden Retriever", subBreed: "")
        var tapCalled = false
        
        // When
        let button = AnswerButton(
            breed: breed,
            hasSelectedAnswer: false,
            isCorrectAnswer: true,
            onTap: { tapCalled = true },
            onAnimationEnd: { }
        )
        
        // Then
        let buttonView = try button.inspect().find(ViewType.Button.self)
        try buttonView.tap()
        XCTAssertTrue(tapCalled)
    }
    
    // Note: Testing animations and async behavior would typically
    // require more advanced testing approaches, possibly with
    // expectations and delays
} 
