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
    
    
    var body: some View {
        VStack {
            Text("Scores")
            List(scores) {score in
                Text("Score: \(score.score)")
                Text("Date: \(score.date)")
            }
        }.navigationBarBackButtonHidden(true).toolbar {
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
