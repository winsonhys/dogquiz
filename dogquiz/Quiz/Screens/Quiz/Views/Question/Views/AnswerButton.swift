//
//  AnswerButton.swift
//  dogquiz
//
//  Created by Winson Heng on 9/3/25.
//

import Foundation
import SwiftUI
import Lottie

struct AnswerButton : View {
    private let breed: Breed
    private let onTap: () -> Void
    private let onAnimationEnd: () -> Void
    let hasSelectedAnswer: Bool
    let isCorrectAnswer: Bool
    
    @State private var startPlay = false
    
    
    
    
    
    init(
        breed: Breed,
        hasSelectedAnswer: Bool,
        isCorrectAnswer: Bool,
        onTap: @escaping () -> Void,
        onAnimationEnd: @escaping () -> Void
    ) {
        self.breed = breed
        self.onTap = onTap
        self.isCorrectAnswer = isCorrectAnswer
        self.hasSelectedAnswer = hasSelectedAnswer
        self.onAnimationEnd = onAnimationEnd
    }
    
    var body: some View {
        var text = "Breed: \(breed.mainBreed)"
        if breed.subBreed != "" {
            text.append("\r\n\r\nSub breed: \(breed.subBreed)")
        }
        // Changes tint based on the answer selected
        let buttonTint = {
            if !hasSelectedAnswer {
                return Color.blue
            }
            if isCorrectAnswer {
                return Color.green
            }
            return Color.red
        }()
        
        return ZStack {
            Button(action: {
                onTap()
                if isCorrectAnswer {
                    startPlay = true
                } else {
                    // Delay this so that the green -> red animation can be played due to color interpolation animation
                    Task {
                        try await Task.sleep(nanoseconds: UInt64(1.5 * Double(NSEC_PER_SEC)))
                        onAnimationEnd()
                    }
                    
                }
                
            }) {
                Text(text).frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            .buttonStyle(.borderedProminent)
            .frame(width: 170, height: 170)
            .tint(buttonTint)
            
            .allowsHitTesting(!hasSelectedAnswer) // Prevent doubletap
            if startPlay {
                LottieView(animation: .named("Lottie_Confetti.json"))
                    .playing(loopMode: .playOnce).animationDidFinish { _ in
                        onAnimationEnd()
                    }
                    
                    .scaledToFit()
                    .allowsHitTesting(false)
            }
            
        }
        
        
    }
}
