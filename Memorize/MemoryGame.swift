//
//  MemoryGame.swift
//  Memorize
//
//  Created by Myat Thiha on 29/06/2024.
//

import Foundation

struct MemoryGame<CardContent>{
    private(set) var cards:[Card]
    
    init(_ numberOfPairsOfCards: Int, cardContentFactory: (Int)->CardContent){
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards){
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        cards.shuffle()
    }
    
    func choose(_ card: Card){
        
    }
    
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }
    
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}
