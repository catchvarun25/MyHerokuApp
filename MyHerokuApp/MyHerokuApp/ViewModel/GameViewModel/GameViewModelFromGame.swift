//
//  GameViewModelFromGame.swift
//  MyHerokuApp
//
//  Created by Varun Mehta on 13/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import Foundation

class GameViewModelFromGame: GameViewModel {
    
    let game: Game
    
    var stepCount: Int
    
    var isFinished: Bool
    
    func resetGame() {
        for (index, _) in game.cards.enumerated() {
            self.game.updateCardAt(index: index, state: .Close)
        }
    }
    func updateCardStateTo(_ state: CardState, forCardAt index: Int) {
        self.game.updateCardAt(index: index, state: state)
        
    }

    init(_ game: Game) {
        self.game       = game
        self.stepCount  = game.steps
        self.isFinished = game.isFinished
    }
}
