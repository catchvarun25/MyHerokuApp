//
//  GameViewControllerTesting.swift
//  MyHerokuAppTests
//
//  Created by Varun Mehta on 16/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import Foundation

import XCTest
@testable import MyHerokuApp

class GameViewControllerTests: XCTestCase {
    var sut:GameViewController?

    override class func setUp() {
        let gameManager:MockGameManager = MockGameManager.shared
        gameManager.startGame()
    }

    override func setUpWithError() throws {
        //Given
        let gameManager:MockGameManager = MockGameManager.shared
        let viewModel: GameViewModel = MockGameViewModel(gameManager.game, manager: gameManager)
        sut = GameViewController(model: viewModel)
        _ = sut?.view
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testUIElementsAttribute() throws {
        XCTAssertEqual(sut?.resetButton.titleLabel?.text, "Restart Game")
        XCTAssertEqual(sut?.stepCountLabel.text, "STEPS:0")
        XCTAssertEqual(sut?.cardCollection.numberOfSections, 1)
        XCTAssertEqual(sut?.cardCollection.numberOfItems(inSection: 0), 12)
    }

    func testUIElementsExist() throws {
        XCTAssertNotNil(sut?.resetButton)
        XCTAssertNotNil(sut?.stepCountLabel)
        XCTAssertNotNil(sut?.cardCollection)
    }

}
