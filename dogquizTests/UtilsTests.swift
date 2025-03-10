//
//  UtilsTests.swift
//  dogquizTests
//
//  Created by Winson Heng on 9/3/25.
//

import XCTest
import SwiftUI
@testable import dogquiz

final class UtilsTests: XCTestCase {
    
    // MARK: - getBreedFromImageUrlString Tests
    
    func testGetBreedFromValidUrl() {
        // Test with a standard URL format
        let url = "https://images.dog.ceo/breeds/vizsla/n02100583_11752.jpg"
        let breed = Utils.getBreedFromImageUrlString(url)
        
        XCTAssertEqual(breed.mainBreed, "vizsla")
        XCTAssertEqual(breed.subBreed, "")
    }

    func testGetBreedSubbreedFromValidUrl() {
        // Test with a standard URL format
        let url = "https://images.dog.ceo/breeds/hound-english/n02089973_4359.jpg"
        let breed = Utils.getBreedFromImageUrlString(url)
        
        XCTAssertEqual(breed.mainBreed, "hound")
        XCTAssertEqual(breed.subBreed, "english")
    }
    
    func testGetBreedFromInvalidUrl() {
        // Test with a URL that doesn't contain the expected format
        let url = "https://example.com/something/else"
        let breed = Utils.getBreedFromImageUrlString(url)
        
        XCTAssertEqual(breed.mainBreed, "")
    }
    
    func testGetBreedFromEmptyString() {
        // Test with an empty string
        let url = ""
        let breed = Utils.getBreedFromImageUrlString(url)
        
        XCTAssertEqual(breed.mainBreed, "")
    }
    
    // MARK: - Color Hex Initializer Tests
    
    func testColorWithValidHexString() {
        // Test with valid hex string (with #)
        let color = Color(hex: "#FF0000")
        
        // Convert the color to RGB components for testing
        // Note: In a real test, you might need to extract components differently
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        XCTAssertEqual(red, 1.0, accuracy: 0.01)
        XCTAssertEqual(green, 0.0, accuracy: 0.01)
        XCTAssertEqual(blue, 0.0, accuracy: 0.01)
    }
    
    func testColorWithHexStringWithoutHash() {
        // Test with valid hex string (without #)
        let color = Color(hex: "00FF00")
        
        // Convert the color to RGB components for testing
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        XCTAssertEqual(red, 0.0, accuracy: 0.01)
        XCTAssertEqual(green, 1.0, accuracy: 0.01)
        XCTAssertEqual(blue, 0.0, accuracy: 0.01)
    }
    
} 
