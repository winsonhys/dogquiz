//
//  Quiz 2.swift
//  dogquiz
//
//  Created by Winson Heng on 10/3/25.
//


import Foundation
import SwiftUI
import SwiftData
import Dependencies

struct QuizView: View {
    // For SwiftData
    @Environment(\.modelContext) private var modelContext
    
    
    @Dependency(\.date.now) var now
    
    @State private var model = QuizModel()
    @State var isLoading = true
    
    @State  var currentQuestion: QuestionModel?
    @State  var currentScore = 0
    @State  var questionsCompleted = 0;
    
    @Environment(\.dismiss) private var dismiss
    @State private var showExitConfirmation = false
    
    
    @ViewBuilder
    private func questionView(_ question: QuestionModel) -> some View {
        
        VStack {
            HStack {
                Text("Current Score: \(currentScore)")
                Spacer()
                Text("Questions Left: \(QuizModel.kMaxQuestionsCount - questionsCompleted)")
            }.padding([.leading, .trailing], 16)
            
            QuestionView(questionModel: question, onCorrectAnswer: {
                currentScore += 1
                let nextQuestion = model.getNextQuestion()
                currentQuestion = nextQuestion
                questionsCompleted += 1
            }, onWrongAnswer: {
                
                let nextQuestion = model.getNextQuestion()
                currentQuestion = nextQuestion
                questionsCompleted += 1
            })
        }
    }
    
    
    var questionFinishedView: some View {
        // Trigger redirection
        Rectangle()
           .hidden()
           .onAppear {
               let score = Score(date: now, score: currentScore)
               // To persist scores to see score history.
               modelContext.insert(score)
               try? modelContext.save()
               Router.shared.path.append(Router.Routes.history)
           }
    }
    
    var mainBody: some View {
        
        Group {
            if isLoading {
                VStack {
                    ProgressView().scaledToFill()
                }
                
            } else if questionsCompleted == QuizModel.kMaxQuestionsCount {
                questionFinishedView
            }
            else if let question = currentQuestion {
                questionView(question)
            } else {
                questionFinishedView
            }
        }.background(Utils.backgroundColor, ignoresSafeAreaEdges: .all)
        .navigationBarBackButtonHidden(true).toolbar {
            if isLoading {
                ToolbarItem {
                    Rectangle().hidden()
                }
            } else {
                ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                showExitConfirmation = true
                            }) {
                                HStack {
                                    Image(systemName: "chevron.left")
                                    Text("Back")
                                }
                            }
                        }
            }
            
        } .alert("Are you sure you want to go back? 🥺 You are going to lose all your progress", isPresented: $showExitConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Yes", role: .destructive) {
                dismiss() // Allow going back
            }
        }
    }
    
    var body: some View {
        VStack {
            mainBody
        }
        .task {
            await model.load()
            await MainActor.run {
                currentQuestion = model.getNextQuestion()
                isLoading = false
            }
            
        }
    }
}
