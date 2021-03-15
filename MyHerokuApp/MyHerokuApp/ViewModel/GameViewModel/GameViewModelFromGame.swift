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
    
    private(set) var stepCount: Rx<Int>
    
    private(set) var isFinished: Rx<Bool>
    
    private(set) var isReset: Rx<Bool>
    
    private(set) var selectedCardIndex:Rx<Int>
    
    private(set) var firstOpenCard:(index:Int, card:Card)?
    
    private(set) var secondOpenCard:(index:Int, card:Card)?
    
    init(_ game: Game) {
        self.game       = game
        self.stepCount  = Rx(game.steps)
        self.isFinished = Rx(game.isFinished)
        self.isReset    = Rx(false)
        self.selectedCardIndex = Rx(0)
    }
    
    func resetGame() {
        guard game.state != .NotStarted else {
            return
        }
        //Reset Game Model
        let gameManager = GameManager.shared
        gameManager.resetGame {
            self.isReset.value = true
        }
        //Reset
        self.stepCount.value = self.game.steps
        self.game.updateGameState(state: .NotStarted)

    }
    
    func didSelectCardAt(index: Int) {
        
        if firstOpenCard == nil || secondOpenCard == nil {
            let selectedCard = self.game.cards[index]
            guard selectedCard.state == .Close && self.game.state != .Ended else {
                return
            }
            
            if self.game.state == .NotStarted {
                self.game.updateGameState(state: .InProgress)
            }
            
            selectedCard.updateCard(state: .Open)
            self.game.incrementSteps()
            self.stepCount.value = self.game.steps
            self.selectedCardIndex.value = index
            
            //Check if game finishes
            if checkIfFinished() {
                self.game.updateGameState(state: .Ended)
                self.isFinished.value = true
            } else {
                if firstOpenCard == nil {
                    firstOpenCard = (index, selectedCard)
                } else {
                    secondOpenCard = (index, selectedCard)
                    if firstOpenCard?.card.number != secondOpenCard?.card.number {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.firstOpenCard?.card.updateCard(state: .Close)
                            self.secondOpenCard?.card.updateCard(state: .Close)
                            self.selectedCardIndex.value = self.firstOpenCard!.index
                            self.selectedCardIndex.value = self.secondOpenCard!.index
                            self.firstOpenCard = nil
                            self.secondOpenCard = nil
                        }
                    } else {
                        firstOpenCard = nil
                        secondOpenCard = nil
                    }
                }
            }
        }
        
    }
    
    //MARK:- Private Methods -
    
    /**
     To check the state of the game through the state of all cards.
     */
    fileprivate func checkIfFinished() -> Bool {
        for card in self.game.cards {
            if card.state == .Close { //If any card in CLOSED state
                return false
            }
        }
        return true
    }
}
