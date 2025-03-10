//
//  AnswerButton.swift
//  dogquiz
//
//  Created by Winson Heng on 9/3/25.
//

import Foundation
import SwiftUI

struct AnswerButton : View {
    private let breed: Breed
    private let onTap: (Breed) -> Void
    
    init(breed: Breed, onTap: @escaping (Breed) -> Void) {
        self.breed = breed
        self.onTap = onTap
    }
    
    var body: some View {
        var text = "Breed: \(breed.mainBreed)"
        if breed.subBreed != "" {
            text.append("\r\n Sub breed: \(breed.subBreed)")
        }
        return Button(action: {
            onTap(breed)
        }) {
            Text(text)
        }
    
        
    }
}
