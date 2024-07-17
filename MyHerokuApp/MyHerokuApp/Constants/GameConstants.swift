//
//  GameConstants.swift
//  MyHerokuApp
//
//  Created by Varun Mehta on 13/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import Foundation

struct Constants {
    static let CARD_PAIRS_VALUE = 6
    static let NUMBER_OF_CARDS = CARD_PAIRS_VALUE * 2
    
    struct GameView {
        struct Literals {
            static let RESET_BTN_LABEL  = "Restart Game"
            static let STEP_COUNT_LABEL = "STEPS:%d"
        }
        struct Design {
            static let RESET_BTN_HEIGHT     = 44.0
            static let RESET_BTN_WIDTH      = 200.0
            static let STEPCOUNT_LBL_HEIGHT = 44.0
        }
    }
    
    struct CardView {
        struct Literals {
            static let CARD_CELL_IDENTIFIER = "CardViewCell"
        }
    }
    
    struct AlertView {
        struct Congrats {
            static let TITLE     = "Congrats!"
            static let MESSAGE   = "You completed in %d steps."
            static let TRY_AGAIN = "Try Again"
        }
    }
    
    
}
