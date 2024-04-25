//
//  GameViewModelFromGame.swift
//  MyHerokuApp
//
//  Created by Varun Mehta on 13/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import Foundation

class GameViewModelFromGame: GameViewModel {
    private let gameManager: GameControls
    private(set) var game: Game
    
    private(set) var stepCount: Rx<Int>
    
    @Published
    private var isFinished: Bool
    var isFinishedPublisher: Published<Bool>.Publisher { $isFinished }
    
    @Published
    private var isReset: Bool
    var isResetPublisher: Published<Bool>.Publisher { $isReset }

    @Published
    private var selectedCardIndex:Int
    var selectedCardIndexPublisher: Published<Int>.Publisher { $selectedCardIndex }

    private(set) var firstOpenCard:(index:Int, card:Card)?
    
    private(set) var secondOpenCard:(index:Int, card:Card)?
    
    required init(_ game: Game, manager: GameControls) {
        self.game       = game
        self.stepCount  = Rx(game.steps)
        self.isFinished = game.isFinished
        self.isReset    = false
        self.selectedCardIndex = 0
        self.gameManager = manager
    }
    
    func resetGame() {
        guard game.state != .NotStarted else {
            return
        }
        //Reset Game Model
        gameManager.resetGame {
            self.isReset = true
        }
        //Reset
        self.stepCount.value = self.game.steps
        self.game.updateGameState(state: .NotStarted)
        self.firstOpenCard = nil
        self.secondOpenCard = nil
    }
    
    func didSelectCardAt(index: Int) {
        
        if firstOpenCard == nil || secondOpenCard == nil {
            let selectedCard = self.game.cards[index]
            
            //Card state should be closed and game should not be ended
            guard selectedCard.state == .Close && self.game.state != .Ended else {
                return
            }
            
            //On first card selected
            if self.game.state == .NotStarted {
                self.game.updateGameState(state: .InProgress)
            }
            
            selectedCard.updateCard(state: .Open)
            self.game.incrementSteps()
            self.stepCount.value = self.game.steps
            self.selectedCardIndex = index
            
            //Check if game finishes
            if checkIfFinished() {
                self.game.updateGameState(state: .Ended)
                self.isFinished = true
            } else {
                if firstOpenCard == nil {
                    firstOpenCard = (index, selectedCard)
                } else {
                    secondOpenCard = (index, selectedCard)
                    if firstOpenCard?.card.number != secondOpenCard?.card.number {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.firstOpenCard?.card.updateCard(state: .Close)
                            self.secondOpenCard?.card.updateCard(state: .Close)
                            self.selectedCardIndex = self.firstOpenCard!.index
                            self.selectedCardIndex = self.secondOpenCard!.index
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
