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
            scoreBar
            ScrollView{
                cards
                    .animation(.easeInOut, value: viewModel.cards)
            }
        }
        newGameBtn
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
            }
            .padding(4)
        }
        .foregroundColor(viewModel.getThemeColor())
    }
    
    var newGameBtn : some View{
        VStack{
            Button(action: {
                viewModel.restart()
            },
                   label: {
                Image(systemName: "restart.circle.fill")
            })
            Text("New Game").font(.callout)
        }.foregroundColor(.blue)
            .imageScale(.medium)
            .font(.largeTitle)
    }
    
    var scoreBar : some View{
        HStack{
            Text(viewModel.getThemeName())
            Spacer()
            Text(String(viewModel.getScore()))
        }.font(.largeTitle)
            .foregroundColor(.blue)
            .padding(10)
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
