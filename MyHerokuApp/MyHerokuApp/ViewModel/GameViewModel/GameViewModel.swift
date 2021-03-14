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
    var stepCount: Rx<Int> { get }
    var isFinished: Rx<Bool> { get }
    var isReset: Rx<Bool> { get }
    var selectedCardIndex:Rx<Int> { get }
    func resetGame()
    func didSelectCardAt(index: Int)
}
