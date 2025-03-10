//
//  Question.swift
//  dogquiz
//
//  Created by Winson Heng on 9/3/25.
//

import Foundation
import SwiftUI
import Kingfisher

struct QuestionView : View {
    var questionModel: QuestionModel;
    
    var onCorrectAnswer: () -> Void
    var onWrongAnswer: () -> Void
    
    @State private var hasSelectedAnswer = false
    
    init(questionModel: QuestionModel, onCorrectAnswer: @escaping () -> Void, onWrongAnswer: @escaping () -> Void) {
        self.questionModel = questionModel
        self.onCorrectAnswer = onCorrectAnswer
        self.onWrongAnswer = onWrongAnswer
    }
    
    private let flexibleColumn = [
        GridItem(.fixed(170), spacing: 16),
        GridItem(.fixed(170), spacing: 16)
    ]
    var body: some View {
        let answerSelections = questionModel.randomBreedOrder
        return VStack {
            KFImage(questionModel.dogImageUrl).resizable().scaledToFit().padding([.leading, .trailing], 20).frame(maxHeight: 300)
            Text("What is the correct breed?").padding()
            LazyVGrid(columns: flexibleColumn, spacing: 20) {
                ForEach(answerSelections) { answerSelection in
                    let isCorrectAnswer = questionModel.isCorrectAnswer(selectedBreed: answerSelection)
                    AnswerButton(breed: answerSelection, hasSelectedAnswer: hasSelectedAnswer, isCorrectAnswer: isCorrectAnswer, onTap: {
                        hasSelectedAnswer = true
                    }) {
                        if isCorrectAnswer {
                            onCorrectAnswer()
                        } else {
                            onWrongAnswer()
                        }
                        hasSelectedAnswer = false
                    }
                }
            }.padding()
            
        }
    }
}
