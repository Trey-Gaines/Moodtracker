//
//  ContentView.swift
//  Moodtracker
//
//  Created by Trey Gaines on 6/8/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Mood.date, order: .reverse) private var moods: [Mood]
    @State private var slider: Double = 50.0
    @State private var myDate: Date = Date()
    @State private var lastMood: Mood?
    
    var mood: String {
        switch slider {
        case 0...20: return "Very Sad 😢"
        case 21...40: return "Sad 🙁"
        case 41...60: return "Neutral 😐"
        case 61...80: return "Happy 🙂"
        case 81...100: return "Very Happy 😄"
            default: return ""
        }
    }
    var count: Int { moods.count }
    
    var emoji: String {
        guard !mood.isEmpty else { return "" }
        return String(mood.last!)
    }
    
    var lastMoodStr: String {
        guard let lastMood = lastMood else { return "Record a Mood!" }
        let formattedDate = formateDate(lastMood.date)
        let moodDescription = lastMood.mood.last!
        return "On \(formattedDate) you felt \(moodDescription)"
        
    }
    
    var body: some View {
        VStack(spacing: 25) {
            Spacer()
            VStack {
                Text("\(mood)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    
                Slider(value: $slider,
                       in: 1...100, step: 1.0)
                .padding()
                Text("\(Int(slider))")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }.transition(.opacity)
            
            VStack {
                DatePicker("Pick a date!", selection: $myDate, displayedComponents: [.date])
                    .padding()
            }
            Spacer()
            VStack {
                Button {
                    addItem()
                } label: {
                    Text("Add Item")
                        .foregroundStyle(Color.white)
                        .background {
                            RoundedRectangle(cornerRadius: 25.0).fill(Color.blue)
                                .frame(width: 150, height: 50)
                        }
                }
                Text("\(lastMoodStr)")
                    .padding(25)
            }
        }
        .padding()
        .onAppear { if !moods.isEmpty { lastMood = moods[0] } }
    }
    
    private func addItem() {
        let newMood = Mood(mood: emoji, date: myDate)
        lastMood = newMood; modelContext.insert(newMood)
    }
    
    private func formateDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Mood.self, inMemory: true)
}
