//
//  ContentView.swift
//  FlagMatch
//
//  Created by Larry Nguyen on 9/7/20.
//  Copyright © 2020 Larry Nguyen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Spain","UK","US"].shuffled()
    var correctAnswer = Int.random(in: 0...2)
    
    
    var body: some View {
        
        ZStack {
            
            RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 800).edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Text("Tap the flag of")
                    .foregroundColor(Color.white)
                Text(countries[correctAnswer])
                    .foregroundColor(Color.white)
                
                VStack(spacing: 20) {
                    ForEach (0 ..< 3) { number in
                        Button(action: {
                        }) {
                            Image(self.countries[number]).renderingMode(.original)
                        }
                    }
                    Spacer()

                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
