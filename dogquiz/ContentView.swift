//
//  ContentView.swift
//  dogquiz
//
//  Created by Winson Heng on 6/3/25.
//

import SwiftUI



struct ContentView: View {
    @State private var router = Router.shared

    var body: some View {
        NavigationStack(path: $router.path) {
            Start().navigationDestination(for: Router.Routes.self) { route in
                Router.shared.viewForRoute(route)
            }
        }
        
    }
}

#Preview {
    ContentView()
}
