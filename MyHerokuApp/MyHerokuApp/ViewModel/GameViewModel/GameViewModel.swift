//
//  GameViewModel.swift
//  MyHerokuApp
//
//  Created by Varun Mehta on 13/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import Foundation

protocol GameViewModel {
    var game: Game { get }
    var stepCount: Rx<Int> { get } // Keeping for reference for our custom RX class
    var isFinishedPublisher: Published<Bool>.Publisher { get }
    var isResetPublisher: Published<Bool>.Publisher { get }
    var selectedCardIndexPublisher:Published<Int>.Publisher { get }
    func resetGame()
    func didSelectCardAt(index: Int)
    init(_ game: Game, manager: GameControls)
}
