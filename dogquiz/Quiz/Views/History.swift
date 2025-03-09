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
    @Query(sort: \Score.date) var scores: [Score]
    
    @State private var score: [Score] = []
    
    var body: some View {
        Text("Scores")
        List(scores) {score in
            Text("Score: \(score.score)")
            Text("Date: \(score.date)")
        }
    }
}
