//
//  GameManager.swift
//  MyHerokuApp
//
//  Created by Varun Mehta on 13/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import Foundation

protocol GameControls {
    var game: Game { get }
    func startGame()
    func resetGame()
}

class GameManager: GameControls {
    var game: Game = Game()
    
    //MARK:- Public Methods -
    func startGame() {
        let numberList = makeNumberList()
        for currentNumber in numberList {
            let card = Card(number: currentNumber)
            game.addCard(card: card)
        }
    }
    
    func resetGame() {
        //Reset Game Model
        self.game.resetGame()        
    }
    //MARK:- Private Methods -
    fileprivate func makeNumberList() -> [UInt32] {
        let numbers = (0..<GameConstants.CARD_PAIRS_VALUE).map { _ in Math.randomIn(1..<100) }
        var final:[UInt32] = [UInt32]()
        final.append(contentsOf: numbers)
        final.append(contentsOf: numbers)
        return final.shuffled()
    }
    
    
    
}
