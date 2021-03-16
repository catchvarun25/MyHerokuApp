//
//  MyHerokuAppTests.swift
//  MyHerokuAppTests
//
//  Created by Varun Mehta on 13/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import XCTest
@testable import MyHerokuApp

class MyHerokuAppTests: XCTestCase {
    var sut:GameViewModelFromGame?
    
    override class func setUp() {
        let gameManager:MockGameManager = MockGameManager.shared
        gameManager.startGame()
    }

    override func setUpWithError() throws {
        
        //Given
        let gameManager:MockGameManager = MockGameManager.shared
        sut = GameViewModelFromGame(gameManager.game, manager: gameManager)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testGameSuccess() throws {
        
        //When
        sut?.didSelectCardAt(index: 0)
        sut?.didSelectCardAt(index: 3)
        sut?.didSelectCardAt(index: 1)
        sut?.didSelectCardAt(index: 11)
        sut?.didSelectCardAt(index: 2)
        sut?.didSelectCardAt(index: 6)
        sut?.didSelectCardAt(index: 4)
        sut?.didSelectCardAt(index: 10)
        sut?.didSelectCardAt(index: 9)
        sut?.didSelectCardAt(index: 5)
        sut?.didSelectCardAt(index: 7)
        sut?.didSelectCardAt(index: 8)

        //Then
        let steps = sut?.game.steps
        let gameState = sut?.game.state
        XCTAssertEqual(steps, 12)
        XCTAssertEqual(gameState, GameState.Ended)
    }
    
    func testGameRestart() throws {
        
        //When
        sut?.didSelectCardAt(index: 1)
        sut?.didSelectCardAt(index: 2)
        sut?.didSelectCardAt(index: 4)
        sut?.didSelectCardAt(index: 10)
        
        sut?.resetGame()
         
        //Then
        let steps      = sut?.game.steps
        let gameState  = sut?.game.state
        let isFinished = sut?.game.isFinished

        XCTAssertEqual(steps, 0)
        XCTAssertEqual(gameState, GameState.NotStarted)
        XCTAssertEqual(isFinished, false)

    }
}
