//
//  Game.swift
//  MyHerokuApp
//
//  Created by Varun Mehta on 13/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import Foundation

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
        guard state == .InProgress else {
            return
        }
        steps.incrementByOne()
    }
    
    func resetGame() {
        guard state == .InProgress else {
            return
        }
        //Reset Steps
        self.state = GameState.NotStarted
        self.steps = 0
        
        //Close All Cards
        for card in cards {
            card.updateCard(state: .Close)
        }
    }
    
    func addCard(card: Card) {
        self.cards.append(card)
    }
    
    func updateCardAt(index: Int, state: CardState) {
        let oldCard = self.cards[index];
        oldCard.updateCard(state: state)
    }
        
    //MARK: - Private Methods -

    /**
     To check the state of the game through the state of all cards.
     */
    fileprivate func checkIfFinished() -> Bool {
        for card in self.cards {
            if card.state == .Close { //If any card in CLOSED state
                return false
            }
        }
        return true
    }
    
    
}
