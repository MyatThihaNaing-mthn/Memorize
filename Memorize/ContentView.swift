//
//  ContentView.swift
//  Memorize
//
//  Created by Myat Thiha on 19/06/2024.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏"]
    @State var cardCount = 4
    var body: some View {
        VStack{
            ScrollView{
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]){
            ForEach(0..<cardCount, id: \.self){ index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    func cardCountAdjuster(by offset:Int, symbol:String) -> some View{
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount+offset < 1 || cardCount+offset > emojis.count)
    }
    
    var cardAdder: some View{
        cardCountAdjuster(by: 1, symbol: "plus.square.on.square")
    }
    
    
    var cardRemover: some View{
        cardCountAdjuster(by: -1, symbol: "minus.square")
    }
    
    var cardCountAdjusters: some View{
        HStack{
            cardAdder
            Spacer()
            cardRemover
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
