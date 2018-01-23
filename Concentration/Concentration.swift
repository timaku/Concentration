//
//  Concentration.swift
//  Concentration
//
//  Created by Student User on 1/14/18.
//  Copyright © 2018 iOS crash course. All rights reserved.
//

import Foundation


class Concentration {
    var cards = [Card]()
        
    var flipCount = 0
    
    var score = 0
    
    var matchedPairs = 0
    
    var gameOver = false
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if !cards[index].isFaceUp {
                flipCount+=1
            }
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    matchedPairs += 1
                    
                    if matchedPairs == cards.count/2 {
                        gameOver = true
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
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        //shuffling the cards
        for index in cards.indices {
            let swapIndex = Int(arc4random_uniform(UInt32(cards.count)))
            cards.swapAt(index, swapIndex)
        }
    }
}
