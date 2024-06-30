//
//  MemoryGame.swift
//  Memorize
//
//  Created by Myat Thiha on 29/06/2024.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards:[Card]
    
    init(_ numberOfPairsOfCards: Int, cardContentFactory: (Int)->CardContent){
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards){
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        cards.shuffle()
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int?
    
    
    mutating func choose(_ card: Card){
        if let index = cards.firstIndex(where: {$0.id == card.id }){
            if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard{
                if cards[potentialMatchIndex].content == cards[index].content{
                    cards[index].isMatched = true
                    cards[potentialMatchIndex].isMatched = true

                }
                indexOfOneAndOnlyFaceUpCard = nil
            }else{
                for index in cards.indices{
                    cards[index].isFaceUp = false
                }
                indexOfOneAndOnlyFaceUpCard = index
            }
            cards[index].isFaceUp = true
        }
    }
    
    
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible{
        var debugDescription: String{
            return "\(id): \(content) \(isFaceUp ? "UP" : "DOWN") \(isMatched ? "MATCHED" : "")"
        }
        
        
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        
        var id: String
    }
}
