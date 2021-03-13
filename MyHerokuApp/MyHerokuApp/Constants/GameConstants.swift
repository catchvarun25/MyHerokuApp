//
//  GameConstants.swift
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

struct GameConstants {
    static let CARD_PAIRS_VALUE = 6
    static let NUMBER_OF_CARDS = CARD_PAIRS_VALUE * 2
}
