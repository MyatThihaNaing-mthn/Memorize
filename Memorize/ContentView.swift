//
//  ContentView.swift
//  Memorize
//
//  Created by Myat Thiha on 19/06/2024.
//

import SwiftUI

struct ContentView: View {
    var ballTheme = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏉", "🥏", "🎱", "🪀"]
    var heartTheme = ["🩷", "❤️", "🧡", "💚", "🩵", "💙", "🖤","❤️‍🔥", "💓", "💔"]
    var animalTheme = ["🐶", "🐱", "🐰", "🦊", "🐼", "🐸", "🙈", "🦁", "🦋", "🐝"]
    @State var currentTheme:[String]
    
    init(){
        ballTheme += ballTheme
        heartTheme += heartTheme
        animalTheme += animalTheme
        _currentTheme = State(initialValue: animalTheme)
    }
    @State var cardCount = 4
    var body: some View {
        VStack{
            title
            ScrollView{
                cards
            }
            themeButtonSection
        }
        .padding(4)
    }
    
    var title: some View {
        Text("Memorize!").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
    }
    
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]){
            ForEach(0..<currentTheme.count, id: \.self){ index in
                CardView(content: currentTheme[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    func themeChanger(theme: [String], symbol:String, label:String) -> some View{
        VStack{
            Button(action: {
                currentTheme = theme
                currentTheme.shuffle()
                print("executed", theme)
            }, label: {
                Image(systemName: symbol)
            })
            .disabled(currentTheme == theme)
            Text(label).font(.callout)
        }.foregroundColor(.blue)
        
    }
    
    var animalThemeButton: some View{
        themeChanger(theme: animalTheme, symbol: "pawprint.fill", label: "Animal")
    }
    
    var heartThemeButton: some View{
        themeChanger(theme: heartTheme, symbol: "heart.square.fill", label: "Heart")
    }
    
    var ballThemeButton: some View{
        themeChanger(theme: ballTheme, symbol: "soccerball.circle.fill", label: "Ball")
    }
    
    var themeButtonSection: some View{
        HStack{
            Spacer()
            animalThemeButton
            Spacer()
            heartThemeButton
            Spacer()
            ballThemeButton
            Spacer()
        }
        .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
        .font(.largeTitle)
    }
    
}

struct CardView: View {
    @State var isFaceUp = true
    let content: String
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture{
            isFaceUp.toggle()
        }
    }
}


#Preview {
    ContentView()
}
