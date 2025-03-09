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
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding().task {
            let allBreeds = await model.loadAllBreeds()
        }
    }
}

