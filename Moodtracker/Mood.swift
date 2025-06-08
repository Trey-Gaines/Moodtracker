//
//  Mood.swift
//  Moodtracker
//
//  Created by Trey Gaines on 6/8/25.
//

import Foundation
import SwiftData

@Model
final class Mood {
    var mood: String
    var date: Date
    
    init(mood: String, date: Date) {
        self.mood = mood
        self.date = date
    }
}
