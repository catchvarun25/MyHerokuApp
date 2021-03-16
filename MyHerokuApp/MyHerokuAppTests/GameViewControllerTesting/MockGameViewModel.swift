//
//  MockGameViewModel.swift
//  MyHerokuAppTests
//
//  Created by Varun Mehta on 16/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import Foundation
@testable import MyHerokuApp

class MockGameViewModel: GameViewModel {
    
    var game: Game
    
    var stepCount: Rx<Int>
    
    var isFinished: Rx<Bool>
    
    var isReset: Rx<Bool>
    
    var selectedCardIndex: Rx<Int>
    
    private let gameManager: GameControls
    
    required init(_ game: Game, manager: GameControls) {
        self.game       = game
        self.stepCount  = Rx(game.steps)
        self.isFinished = Rx(game.isFinished)
        self.isReset    = Rx(false)
        self.selectedCardIndex = Rx(0)
        self.gameManager = manager
    }

    
    func resetGame() {
        
    }
    
    func didSelectCardAt(index: Int) {
        
    }
    

}
