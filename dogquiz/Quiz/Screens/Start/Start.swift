//
//  Start.swift
//  dogquiz
//
//  Created by Winson Heng on 10/3/25.
//
import SwiftUI

struct Start : View {
    var body: some View {
        
        Button(action: {
            Router.shared.path.append(Router.Routes.quiz)
        }) {
            Text("Start")
            
        }.toolbar {
            leaderboardBtn
        }
    }
    
    var leaderboardBtn: some View {
        Button(action: {
            Router.shared.path.append(Router.Routes.history)
        }, label: {
            Image(systemName: "chart.bar.fill")
        })
    }
    
}
