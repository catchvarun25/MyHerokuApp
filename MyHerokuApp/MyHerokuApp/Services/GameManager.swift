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
    func resetGame(_ completion: ()->())
    func getRandomNumbers() ->[UInt32]
}

class GameManager: GameControls {
    let game: Game
    static let shared = GameManager()
    private init() {
        game = Game()
    }
    
    //MARK:- Public Methods -
    func startGame() {
        let numberList = getRandomNumbers()
        for currentNumber in numberList {
            let card = Card(number: currentNumber)
            game.addCard(card: card)
        }
    }
    
    func resetGame(_ completion: ()->()) {
        //Reset Game Model
        self.game.resetGame()
        self.startGame()
        completion()
    }
    
    func getRandomNumbers() -> [UInt32] {
        let numbers = (0..<Constants.CARD_PAIRS_VALUE).map { _ in Math.randomIn(1..<100) }
        var final:[UInt32] = [UInt32]()
        final.append(contentsOf: numbers)
        final.append(contentsOf: numbers)
        return final.shuffled()
    }
}
