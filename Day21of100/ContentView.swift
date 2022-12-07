//
//  ContentView.swift
//  Day21of100
//
//  Created by Anand Narayan on 2022-11-28.
//

import SwiftUI

struct ContentView: View {
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland","Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State var selectedValue: Int?
    @State var questionCount = 0
    @State private var showingScore = false
    @State private var showReset = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 15) {

                VStack{
                    Text("Tap the flag").makeBig()
                    Text(countries[correctAnswer]).font(Font.custom("Avenir Heavy", size: 24)).foregroundColor(.orange)
                }
                ForEach(0..<3, id: \.self) { k in
                    
                    Button(action: {
                        selectedValue = k
                        questionCount += 1
                        isAnswerCorrect()
                    }, label: {
                        FlagView(imageName: countries[k])
                    })
                }

               
            }
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("question count: \(questionCount)")
            Text("Your score is: \(score)")
        }
        .alert(scoreTitle, isPresented: $showReset) {
            Button("This game is over.  Reset", action: endGame)
        } message: {
            Text("question count: \(questionCount)")
            Text("Your score is: \(score)")
        }

    } // end of body

    
    func isAnswerCorrect()  {
        if (questionCount < 8) {
            if (selectedValue == correctAnswer) {
                
                score = score + 1
                scoreTitle = "You did it-You have \(score) Points"
            } else {
                scoreTitle = "Wrong! you clicked on \(countries[selectedValue!])"
                if (score > 0) {
                    score = score - 1
                }
                    
            }
            showingScore = true
            showReset = false
        } else {
            showingScore = false
            showReset = true
        }

    }
    
    func endGame() {
        questionCount = 0
        score = 0
        scoreTitle = ""
    }
    
    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
        showingScore = false
    }
    

}

extension View {
    
    func makeBig() -> some View {
        modifier(Title())
    }
}

struct FlagView : View {
    var imageName: String
    var body: some View {
        Image(imageName)
            .resizable()
            .clipShape(Capsule())
            .shadow(radius: 10)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .font(Font.custom("Avenir Heavy", size: 32))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
