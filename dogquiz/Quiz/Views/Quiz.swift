//
//  Quiz.swift
//  dogquiz
//
//  Created by Winson Heng on 9/3/25.
//
import Foundation
import SwiftUI

struct Quiz: View {
    @State private var model = QuizModel()
    @State private var isLoading = true
    
    @State private var currentQuestion: QuestionModel?
    @State private var currentScore = 0
    
    var mainBody: some View {
        Group {
            if isLoading {
                ProgressView()
            } else if let question = currentQuestion {
                VStack {
                    Text("Current Score: \(currentScore)")
                    Question(questionModel: Binding { question } set: { currentQuestion = $0 }, onCorrectAnswer: {
                        currentScore += 1
                        let nextQuestion = model.getNextQuestion()
                        currentQuestion = nextQuestion
                    }, onWrongAnswer: {
                        let nextQuestion = model.getNextQuestion()
                        currentQuestion = nextQuestion
                    })
                }
                
            } else {
                EmptyView()
            }
        }
    }
    
    var body: some View {
        VStack {
            
            mainBody
            
        }.task {
            await model.load()
            await MainActor.run {
                currentQuestion = model.getNextQuestion()
                isLoading = false
                
                
            }
            
        }
    }
}

