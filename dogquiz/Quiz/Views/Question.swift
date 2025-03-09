//
//  Question.swift
//  dogquiz
//
//  Created by Winson Heng on 9/3/25.
//

import Foundation
import SwiftUI
import Kingfisher

struct Question : View {
    var questionModel: QuestionModel;
    
    var onCorrectAnswer: () -> Void
    var onWrongAnswer: () -> Void
    
    init(questionModel: QuestionModel, onCorrectAnswer: @escaping () -> Void, onWrongAnswer: @escaping () -> Void) {
        self.questionModel = questionModel
        self.onCorrectAnswer = onCorrectAnswer
        self.onWrongAnswer = onWrongAnswer
    }
    
    private let flexibleColumn = [
        GridItem(.flexible(minimum: 100, maximum: 200)),
        GridItem(.flexible(minimum: 100, maximum: 200)),
    ]
    var body: some View {
        let answerSelections = questionModel.getRandomBreedOrder()
        return VStack {
            KFImage(questionModel.dogImageUrl).resizable().scaledToFit().padding([.leading, .trailing], 20).frame(maxHeight: 300)
            Text("What is the correct breed?")
            LazyVGrid(columns: flexibleColumn, spacing: 20) {
                ForEach(answerSelections) { answerSelection in
                    AnswerButton(breed: answerSelection) { selectedBreed in
                        if questionModel.isCorrectAnswer(selectedBreed: selectedBreed) {
                            onCorrectAnswer()
                        } else {
                            onWrongAnswer()
                        }
                    }
                }
            }
            
        }
    }
}
