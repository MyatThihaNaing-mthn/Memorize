//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Myat Thiha on 29/06/2024.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject{
    
    // static variable will be initialized first
//    var ballTheme = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏉", "🥏", "🎱", "🪀"]
//    var heartTheme = ["🩷", "❤️", "🧡", "💚", "🩵", "💙", "🖤","❤️‍🔥", "💓", "💔"]
    private static let animalTheme = ["🐶", "🐱", "🐰", "🦊", "🐼", "🐸", "🙈", "🦁", "🦋", "🐝"]
    
    static func createMemoryGame() -> MemoryGame<String>{
        return MemoryGame(
            8){ index in
                if animalTheme.indices.contains(index){
                    return animalTheme[index]
                }else{
                    return "❓"
                }
                
            }
    }
    
    @Published private var model = createMemoryGame()
    
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
    
    func shuffle(){
        model.shuffle()
    }
    
}
