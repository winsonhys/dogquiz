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
            ZStack {
                Utils.backgroundColor.ignoresSafeArea()
                Start().navigationDestination(for: Router.Routes.self) { route in
                    Router.shared.viewForRoute(route)
                }
            }
//                Color(cgColor: CGColor(red: 249, green: 243, blue: 217, alpha: 1)).ignoresSafeArea()
            
        
            
        }
    }
        
        
    
}

#Preview {
    ContentView()
}
