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
    override func setUpWithError() throws {
        let gameManager:MockGameManager = MockGameManager.shared
        gameManager.startGame()
        sut = GameViewModelFromGame(gameManager.game, manager: gameManager)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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

        let steps = sut?.game.steps
        let gameState = sut?.game.state
        //Then
        XCTAssertEqual(steps, 12)
        XCTAssertEqual(gameState, GameState.Ended)
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
