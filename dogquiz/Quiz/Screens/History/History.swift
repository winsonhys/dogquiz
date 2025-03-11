//
//  History.swift
//  dogquiz
//
//  Created by Winson Heng on 10/3/25.
//

import SwiftUI
import SwiftData

struct History: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Score.date, order: .reverse) var scores: [Score]
    
    let dateFormatter = DateFormatter()
    init() {
        dateFormatter.dateFormat = "dd/MM/yy hh:mm a"
    }
    
    
    var body: some View {
        let maxScores = scores.filter { score in
            score.score == QuizModel.kMaxQuestionsCount
        }
        return VStack {
            Text("Scores")
            
                List {
                    Section {
                        if maxScores.isEmpty {
                            Text("Good luck on obtaining full marks!")
                        } else {
                            ForEach(maxScores) { score in
                                HStack {
                                    Text("Score: \(score.score)")
                                    Spacer()
                                    Text("Date: \(dateFormatter.string(from: score.date))")
                                }
                            }
                        }
                        
                    } header: {
                        Text("Full marks go here~")
                    }
                    Section {
                        ForEach(scores) { score in
                            HStack {
                                Text("Score: \(score.score)")
                                Spacer()
                                Text("Date: \(dateFormatter.string(from: score.date))")
                            }
                        }
                    } header: {
                        Text("Score history")
                    }
                }.background(Utils.backgroundColor).scrollContentBackground(.hidden)
            

        }.background(Utils.backgroundColor)
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            
        })
        
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            // Reset to root. This works because this is the final destination screen.
                            // If it is not, to check for previous path before replacing.
                            Router.shared.path = NavigationPath()
                            
                        }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                        }
                    }
        }
        
    }
}
