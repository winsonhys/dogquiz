//
//  ContentView.swift
//  dogquiz
//
//  Created by Winson Heng on 6/3/25.
//

import SwiftUI



struct HomeView: View {
    @State private var router = Router.shared

    var body: some View {
        NavigationStack(path: $router.path) {
            Button(action: {
                router.path.append(Router.Routes.quiz)
            }) {
                Text("Start")
            }.navigationDestination(for: Router.Routes.self) { route in
                Router.shared.viewForRoute(route)
            }
        }
        
    }
}

#Preview {
    HomeView()
}
