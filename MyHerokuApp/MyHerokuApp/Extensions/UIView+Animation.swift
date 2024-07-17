//
//  UIView+Animation.swift
//  MyHerokuApp
//
//  Created by Varun Mehta on 15/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import UIKit

extension UIView {
    
    func flipRightAnimation(_ onComplete: @escaping ()->()) {
        DispatchQueue.main.async {
            UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromRight, animations: {
                onComplete()
            }, completion: nil)
        }
    }
    
    func flipLeftAnimation(_ onComplete: @escaping ()->()) {
        DispatchQueue.main.async {
            UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                onComplete()
            }, completion: nil)
        }
    }
    
}
