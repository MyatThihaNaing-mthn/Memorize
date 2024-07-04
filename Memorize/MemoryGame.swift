//
//  MemoryGame.swift
//  Memorize
//
//  Created by Myat Thiha on 29/06/2024.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards:[Card]
    private var point = 0
    private var flipRecords = [Int]()
    private var isAlreadySeen = false
    
    init(_ numberOfPairsOfCards: Int, cardContentFactory: (Int)->CardContent){
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards){
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        cards.shuffle()
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{return cards.indices.filter{index in cards[index].isFaceUp}.only}
        
        set{cards.indices.forEach{cards[$0].isFaceUp = ($0 == newValue)}
        }
    }
    
    
    mutating func choose(_ card: Card){
        if let index = cards.firstIndex(where: {$0.id == card.id }){
            if !cards[index].isMatched && !cards[index].isFaceUp{
                isAlreadySeen = flipRecords.contains(index)
                if !isAlreadySeen{
                    flipRecords.append(index)
                }
                if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
                    if cards[potentialMatchIndex].content == cards[index].content{
                        cards[index].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        point = point + 2

                    }else{
                        point = isAlreadySeen ? point-1 : point
                    }
                }else{
                    indexOfOneAndOnlyFaceUpCard = index
                    point = isAlreadySeen ? point-1 : point
                }
                cards[index].isFaceUp = true
            }
        }
        print(point)
    }
    

    
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    func getScore() -> Int{
        return point
    }
    
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible{
        var debugDescription: String{
            return "\(id): \(content) \(isFaceUp ? "UP" : "DOWN") \(isMatched ? "MATCHED" : "")"
        }
        
        
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        
        var id: String
    }
}

// To create a method to get the only one faceup card

extension Array{
    var only: Element?{
        count==1 ? first : nil
    }
}
