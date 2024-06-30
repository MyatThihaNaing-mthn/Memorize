//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Myat Thiha on 29/06/2024.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject{
    
    // static variable will be initialized first
    private static let ballTheme = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏉", "🥏", "🎱", "🪀"]
    private static let heartTheme = ["🩷", "❤️", "🧡", "💚", "🩵", "💙", "🖤","❤️‍🔥", "💓", "💔"]
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
    
    func chooseTheme(themeName theme:String){
        switch theme{
        case "heart":
            model.chooseTheme(EmojiMemoryGame.heartTheme)
        case "animal":
            model.chooseTheme(EmojiMemoryGame.animalTheme)
        case "ball":
            model.chooseTheme(EmojiMemoryGame.ballTheme)
        default:
            print("do nothing")
        }
    }
    
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
    
    func shuffle(){
        model.shuffle()
    }
    
}
