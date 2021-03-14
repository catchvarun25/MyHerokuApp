//
//  CardView.swift
//  MyHerokuApp
//
//  Created by Varun Mehta on 13/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import UIKit

class CardView: UICollectionViewCell {
    fileprivate let numberLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment   = NSTextAlignment.center
        label.backgroundColor = .cardLabelBackgroundColor
        label.textColor = .cardLabelTextColorClose
        label.font = .H3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(numberLabel)
        self.applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("Init coder ha")
    }
    
    var card: Card? {
        didSet {
            if card?.state == .Close {
                self.numberLabel.text = "?"
            } else {
                self.numberLabel.text = "\(card!.number)"
            }
            self.updateCardDesign()
        }
    }
    
    fileprivate func updateCardDesign() {
        if self.card?.state == .Close {
            self.backgroundColor = .cardBackgroundColorClose
            self.numberLabel.textColor = .cardLabelTextColorClose
        } else {
            self.backgroundColor = .cardBackgroundColorOpen
            self.numberLabel.textColor = .cardLabelTextColorOpen
        }
    }
    
    fileprivate func applyConstraints() {
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[numberLabel]-|", options: [], metrics: nil, views: ["numberLabel" : numberLabel]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[numberLabel]-|", options: [], metrics: nil, views: ["numberLabel" : numberLabel]))
        self.backgroundColor = .cardBackgroundColorClose
        
    }
    
}
