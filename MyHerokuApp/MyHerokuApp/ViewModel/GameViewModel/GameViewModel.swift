//
//  GameViewModel.swift
//  MyHerokuApp
//
//  Created by Varun Mehta on 13/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import Foundation

protocol GameViewModelProtocol {
    var game: Game { get }
    var stepCount: Rx<Int> { get } // Keeping for reference for our custom RX class
    var isFinishedPublisher: Published<Bool>.Publisher { get }
    var isResetPublisher: Published<Bool>.Publisher { get }
    var selectedCardIndexesPublisher:Published<[Int]>.Publisher { get }
    func resetGame()
    func didSelectCardAt(index: Int)
    init(_ game: Game, manager: GameControls)
}

class GameViewModel: GameViewModelProtocol {
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
    private var selectedCardIndexes:[Int] = [0]
    var selectedCardIndexesPublisher: Published<[Int]>.Publisher { $selectedCardIndexes }

    private(set) var firstOpenCard:(index:Int, card:Card)?
    
    private(set) var secondOpenCard:(index:Int, card:Card)?
    
    required init(_ game: Game, manager: GameControls) {
        self.game       = game
        self.stepCount  = Rx(game.steps)
        self.isFinished = game.isFinished
        self.isReset    = false
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
            let selectedCard = game.cards[index]
            
            //Card state should be closed and game should not be ended
            guard selectedCard.state == .Close && game.state != .Ended else {
                return
            }
            
            //On first card selected
            if game.state == .NotStarted {
                game.updateGameState(state: .InProgress)
            }
            
            selectedCard.updateCard(state: .Open)
            game.incrementSteps()
            stepCount.value = self.game.steps
            selectedCardIndexes = [index]
            
            //Check if game finishes
            if checkIfFinished() {
               game.updateGameState(state: .Ended)
               isFinished = true
            } else {
                if firstOpenCard == nil {
                    firstOpenCard = (index, selectedCard)
                } else {
                    secondOpenCard = (index, selectedCard)
                    if firstOpenCard?.card.number != secondOpenCard?.card.number {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                            guard let self = self else { return }
                            self.firstOpenCard?.card.updateCard(state: .Close)
                            self.secondOpenCard?.card.updateCard(state: .Close)
                            self.selectedCardIndexes = [self.firstOpenCard!.index, self.secondOpenCard!.index]
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
