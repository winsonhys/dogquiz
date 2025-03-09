//
//  ScoreService.swift
//  dogquiz
//
//  Created by Winson Heng on 10/3/25.
//
import SwiftData
import Foundation

@Model
final class Score {
    var date: Date
    var score: Int
    init(date: Date, score: Int) {
        self.date = date
        self.score = score
    }
}

