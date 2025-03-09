//
//  Router.swift
//  dogquiz
//
//  Created by Winson Heng on 9/3/25.
//
import SwiftUI

// This can probably be generated. Since deeplinking is not part of the requirements, this would
// currently satisfy our use case.

@Observable
class Router {
    var path = NavigationPath()
    
    static let shared = Router()
    
    private init() {}
    enum Routes {
        case quiz
        
    }
    
    func viewForRoute(_ route: Routes) -> AnyView {
            switch route {
            case .quiz:
                return AnyView(Quiz())
            }
        }

}


