//
//  Concentration.swift
//  Concentration
//
//  Created by Student User on 1/14/18.
//  Copyright © 2018 iOS crash course. All rights reserved.
//

import Foundation


class Concentration {
    private(set) var cards = [Card]()
    var score = 0
    var matchedPairs = 0
    var gameOver = false
    
    var maxScore = Int.min
    var minScore = Int.max
    var numberOfPairs = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int?
    
    func restart() {
        score = 0
        matchedPairs = 0
        gameOver = false
        cards = [Card]()
        
        for _ in 1...self.numberOfPairs {
            let card = Card()
            cards += [card, card]
        }
        
        //shuffling the cards
        for index in cards.indices {
            let swapIndex = Int(arc4random_uniform(UInt32(cards.count)))
            cards.swapAt(index, swapIndex)
        }
    }
    
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    matchedPairs += 1
                    
                    if matchedPairs == cards.count/2 {
                        gameOver = true
                        maxScore = maxScore > score ? maxScore : score
                        minScore = minScore < score ? minScore : score
                    }
                } else {
                    if cards[matchIndex].beenSeen {
                        score -= 1
                    }
                    if cards[index].beenSeen {
                        score -= 1
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                
                cards[index].beenSeen = true
                cards[matchIndex].beenSeen = true
            } else {
                //either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair")
        self.numberOfPairs = numberOfPairsOfCards
        restart()
    }
}
