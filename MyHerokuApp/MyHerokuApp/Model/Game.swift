//
//  Game.swift
//  MyHerokuApp
//
//  Created by Varun Mehta on 13/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import Foundation

enum GameState {
    case NotStarted
    case InProgress
    case Ended
}

class Game {
    private(set) var steps: Int       //steps taken by user
    private(set) var state:GameState  //Current state of game
    private(set) var cards: [Card]    //Keep the state of every card
    private(set) var isFinished:Bool  //To check game state
    init() {
        self.steps = 0
        self.state = .NotStarted
        self.cards = []
        self.isFinished = false
    }
    //MARK:- Public Methods -
    func incrementSteps()  {
        self.steps.incrementByOne()
    }
    
    func resetGame() {
        //Reset Steps
        self.state = GameState.NotStarted
        self.steps = 0
        self.cards.removeAll()
    }
    
    func addCard(card: Card) {
        self.cards.append(card)
    }
    
    func updateGameState(state: GameState) {
        self.state = state
    }
    
}
