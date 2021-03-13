//
//  Card.swift
//  MyHerokuApp
//
//  Created by Varun Mehta on 13/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import Foundation

class Card {
    let number: UInt32          //Random number on card
    var state:CardState      // Card Open OR Close
    
    init(number: UInt32) {
        self.number = number
        self.state = .Close
    }
    
    func updateCard(state: CardState) {
        self.state = state
    }
    
}
