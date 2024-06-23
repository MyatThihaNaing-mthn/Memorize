//
//  ContentView.swift
//  Memorize
//
//  Created by Myat Thiha on 19/06/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack{
            CardView(isFaceUp: true)
            CardView()
            CardView(isFaceUp: true)
            CardView()
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    @State var isFaceUp = false
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp{
                base
                    .fill(.white)
                    base
                        .strokeBorder(lineWidth: 2)
                    Text("❤️").font(.largeTitle)
                } else {
                    base.fill()
                }
        }
        .onTapGesture{
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
