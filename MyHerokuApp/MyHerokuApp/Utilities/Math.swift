//
//  Math.swift
//  MyHerokuApp
//
//  Created by Varun Mehta on 13/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import Foundation

class Math {
    class func randomIn(_ range: Range<UInt32>) -> UInt32 {
        let randomNum = arc4random_uniform(range.upperBound) + range.lowerBound
        return randomNum
    }
}
