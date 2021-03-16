//
//  MockGameManager.swift
//  MyHerokuAppTests
//
//  Created by Varun Mehta on 16/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import Foundation
@testable import MyHerokuApp

class MockGameManager: GameControls {
    var game: Game
    static let shared = MockGameManager()
    private init() {
        game = Game()
    }

    func startGame() {
        let numberList = getRandomNumbers()
        for currentNumber in numberList {
            let card = Card(number: currentNumber)
            game.addCard(card: card)
        }
    }
    
    func resetGame(_ completion: () -> ()) {
        //Reset Game Model
        self.game.resetGame()
        self.startGame()
        completion()
    }
    
    func getRandomNumbers() -> [UInt32] {
        return [64, 92, 85, 64, 47, 32, 85, 53, 53, 32, 47, 92]
    }
}
