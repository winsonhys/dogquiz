//
//  dogquizApp.swift
//  dogquiz
//
//  Created by Winson Heng on 6/3/25.
//

import SwiftUI
import OpenAPIURLSession

@main
struct dogquizApp: App {
    @Environment(\.modelContext) private var modelContext
    var body: some Scene {
        WindowGroup {
            HomeView().modelContainer(for: [Score.self])
        }
    }
}
