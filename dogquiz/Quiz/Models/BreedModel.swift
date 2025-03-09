//
//  BreedModel.swift
//  dogquiz
//
//  Created by Winson Heng on 9/3/25.
//

struct Breed: Equatable {
    let mainBreed: String
    let subBreed: String
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.mainBreed == rhs.mainBreed &&
        lhs.subBreed == rhs.subBreed
    }
    init(mainBreed: String = "", subBreed: String  = "") {
        self.mainBreed = mainBreed
        self.subBreed = subBreed
    }
}
