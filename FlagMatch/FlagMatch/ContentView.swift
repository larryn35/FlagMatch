//
//  ContentView.swift
//  FlagMatch
//
//  Created by Larry Nguyen on 9/7/20.
//  Copyright © 2020 Larry Nguyen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showScore = false
    
    @State private var score = 0
    @State private var numberOfQuestions = 0
    @State private var message = ""
    @State private var scoreTitle = ""
    
    var percentCorrect: Double {
        if score == 0 {
            return 0
        } else {
            return (Double(score) / Double(numberOfQuestions) + 0) * 100
        }
    }
    
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Spain","UK","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    
    var body: some View {
        
        ZStack {
            
            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 800)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                
                Spacer()
                Text("Tap the flag of")
                    .foregroundColor(Color.white)
                    .font(.title)
                Text(countries[correctAnswer])
                    .foregroundColor(Color.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                
                VStack(spacing: 20) {
                    ForEach (0 ..< 3) { number in
                        Button(action: {
                            self.flagTapped(number)
                        }) {
                            Image(self.countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                .shadow(color: .black, radius: 2)
                        }
                    }
                    
                    Spacer()
                    
                    Text("Score: \(score) / \(numberOfQuestions) (\(percentCorrect, specifier: "%.0f")%)")
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                               
                    Spacer()
                    
                    Button(action: {
                        self.score = 0
                        self.numberOfQuestions = 0
                        self.askQuestions()
                    }) {
                        Text("Reset score")
                            .font(.body)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(40)
                            .foregroundColor(Color.black)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.white, lineWidth: 5))
                    }
                    
                    Spacer()

                }
            }
                
            .alert(isPresented: $showScore) {
                Alert(title: Text(scoreTitle), message: Text(message), dismissButton: .default(Text("Continue")) {
                    self.askQuestions()
                    })
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            message = "Good job!"
            score += 1
            numberOfQuestions += 1
        } else {
            scoreTitle = "Incorrect"
            message = "That is the flag of \(countries[number])"
            numberOfQuestions += 1
        }
        
        showScore = true
    }
    
    func askQuestions() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
