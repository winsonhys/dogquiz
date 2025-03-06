//
//  DogBreed.swift
//  dogquiz
//
//  Created by Winson Heng on 6/3/25.
//
import Foundation
import SwiftUI

@Observable
class Dog: Identifiable {
    init(breed: String, image: String) {
        self.breed = breed
        self.image = image
    }
    var breed: String
    var image: String
}
