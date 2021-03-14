//
//  CardConstants.swift
//  MyHerokuApp
//
//  Created by Varun Mehta on 13/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import Foundation

enum CardState {
    case Open
    case Close
}

struct CardConstant {
    struct size {
        static let height = 60.0
        static let width = 30.0
    }
    struct border {
        static let radius = 5.0
        static let width  = 2.0
    }
}
