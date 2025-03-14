//
//  BreedModel.swift
//  dogquiz
//
//  Created by Winson Heng on 9/3/25.
//

struct Breed: Equatable, Hashable, Identifiable {
    let mainBreed: String
    let subBreed: String
    
    
    var id: String { "\(mainBreed)-\(subBreed)" }
    
    
    init(mainBreed: String = "", subBreed: String  = "") {
        self.mainBreed = mainBreed
        self.subBreed = subBreed
    }
}
