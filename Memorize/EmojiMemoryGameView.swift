//
//  ContentView.swift
//  Memorize
//
//  Created by Myat Thiha on 19/06/2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack{
            title
            ScrollView{
                cards
                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: viewModel.cards)
            }
            themeButtonSection
        }
        .padding(4)
    }
    
    var title: some View {
        Text("Memorize!").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
    }
    
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 90), spacing: 0)], spacing: 0){
            ForEach(viewModel.cards){ card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
                    .disabled(card.isMatched)
            }
            .padding(4)
        }
        .foregroundColor(.orange)
    }
    
    func themeChanger(theme: [String], symbol:String, label:String) -> some View{
        VStack{
            Button(action: {
                viewModel.shuffle()
            }, label: {
                Image(systemName: symbol)
            })
            Text(label).font(.callout)
        }.foregroundColor(.blue)
        
    }
    
    var animalThemeButton: some View{
        themeChanger(theme: [String](), symbol: "pawprint.fill", label: "Animal")
    }
    
    var heartThemeButton: some View{
        themeChanger(theme: [String](), symbol: "heart.square.fill", label: "Heart")
    }
    
    var ballThemeButton: some View{
        themeChanger(theme: [String](), symbol: "soccerball.circle.fill", label: "Ball")
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
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content).font(.system(size: 200))
                    .aspectRatio(1, contentMode: .fit)
                    .minimumScaleFactor(0.001)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}


#Preview {
    EmojiMemoryGameView(viewModel:  EmojiMemoryGame())
}
