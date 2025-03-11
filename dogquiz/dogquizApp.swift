//
//  dogquizApp.swift
//  dogquiz
//
//  Created by Winson Heng on 6/3/25.
//
import IssueReporting
import SwiftUI
import OpenAPIURLSession
import Dependencies

@main
struct dogquizApp: App {
    @Environment(\.modelContext) private var modelContext
    var body: some Scene {
        WindowGroup {
            if !isTesting {
                ContentView().modelContainer(for: [Score.self])
            } else {
                withDependencies {
                    $0.context = .test
                  } operation: {
                      ContentView()
                  }
            }
            
            
        }
    }
}
