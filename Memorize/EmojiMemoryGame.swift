//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Myat Thiha on 29/06/2024.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject{
    private var theme: Theme
    @Published private var model: MemoryGame<String>

    static func createMemoryGame(currentTheme: Theme) -> MemoryGame<String>{
        return MemoryGame(
            8){ index in
                if currentTheme.emojis.indices.contains(index){
                    return currentTheme.emojis[index]
                }else{
                    return currentTheme.emojis.randomElement()!
                }
                
            }
    }
    
    init() {
        theme = Theme.allCases.randomElement()!
        self.model = EmojiMemoryGame.createMemoryGame(currentTheme: theme)
    }
    
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    
    func restart(){
        theme = Theme.allCases.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(currentTheme: theme)
    }
    
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    func getThemeColor() -> Color{
        return theme.color
    }
    
    func getThemeName() -> String{
        return theme.name
    }
    
    func getScore() -> Int{
        return model.getScore()
    }
    
    
    enum Theme: CaseIterable{
        case ballTheme
        case heartTheme
        case animalTheme
        
        var name: String{
            switch self{
            case .animalTheme:
                return "Animal Theme"
                
            case .ballTheme:
                return "Ball Theme"
            
            case .heartTheme:
                return "Heart Theme"
            }
        }
        
        var emojis: [String]{
            switch self{
            case .animalTheme:
                return ["🐶", "🐱", "🐰", "🦊", "🐼", "🐸", "🙈", "🦁", "🦋", "🐝"]
                
            case .ballTheme:
                return ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏉", "🥏", "🎱", "🪀"]
            
            case .heartTheme:
                return ["🩷", "❤️", "🧡", "💚", "🩵", "💙", "🖤","❤️‍🔥", "💓", "💔"]
                }
            }
        
        var color: Color{
            switch self{
                case .animalTheme:
                return Color.orange
                    
                case .ballTheme:
                return Color.green
                
                case .heartTheme:
                return Color.red
            }
        }
    }
    
}
