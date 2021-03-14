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
    var stepCount: Int { get }
    var isFinished: Bool { get }
    func resetGame()
    func updateCardStateTo(_ state: CardState, forCardAt index: Int)
}
