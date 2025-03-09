//
//  Quiz.swift
//  dogquiz
//
//  Created by Winson Heng on 9/3/25.
//
import Foundation
import SwiftUI
import SwiftData

struct Quiz: View {
    // For SwiftData
    @Environment(\.modelContext) private var modelContext
    
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
                    Question(questionModel: question, onCorrectAnswer: {
                        currentScore += 1
                        let nextQuestion = model.getNextQuestion()
                        currentQuestion = nextQuestion
                    }, onWrongAnswer: {
                        let nextQuestion = model.getNextQuestion()
                        currentQuestion = nextQuestion
                    })
                }
                
            } else {
                Rectangle()
                   .hidden()
                   .onAppear {
                       let score = Score(date: Date.now, score: currentScore)
                       // To persist scores to see score history.
                       modelContext.insert(score)
                       try? modelContext.save()
                       Router.shared.path.append(Router.Routes.history)
                   }
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

