//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Donald Timpson on 1/26/22.
//

import Foundation

struct MemorizeGame<CardContent: Equatable> {
    private(set) var cards: [Card]
    private var faceUpCardIndex: Int?
    
    init(numberOfPairs: Int, contentForPair: (Int) -> CardContent) {
        cards = [Card]()
        for i in 0..<numberOfPairs {
            let content = contentForPair(i)
            cards.append(Card(content: content, id: i*2))
            cards.append(Card(content: content, id: i*2 + 1))
        }
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }), !cards[index].isFaceUp && !cards[index].isMatched {
            if let faceUpIndex = faceUpCardIndex {
                if card.content == cards[faceUpIndex].content {
                    cards[index].isMatched = true
                    cards[faceUpIndex].isMatched = true
                }
                faceUpCardIndex = nil
            } else {
                cards.indices.forEach({ cards[$0].isFaceUp = false })
                faceUpCardIndex = index
            }
            
            cards[index].isFaceUp.toggle()
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
