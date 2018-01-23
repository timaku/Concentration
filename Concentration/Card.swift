//
//  Card.swift
//  Concentration
//
//  Created by Student User on 1/14/18.
//  Copyright © 2018 iOS crash course. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    var beenSeen = false
    
    static var identifierFactory  = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
