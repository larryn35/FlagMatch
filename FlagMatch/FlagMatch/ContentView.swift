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
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Spain","UK","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    
    var body: some View {
        
        ZStack {
            
            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 800)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
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
                    
                }
            }
                
            .alert(isPresented: $showScore) {
                Alert(title: Text(scoreTitle), message: Text("Your score is ???"), dismissButton: .default(Text("Continue")) {
                    self.askQuestions()
                    })
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Incorrect"
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
