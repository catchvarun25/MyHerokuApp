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
        self.card = Card(number: 0)
        super.init(frame: .zero)
        contentView.addSubview(numberLabel)
        self.layer.cornerRadius = CGFloat(CardConstant.border.radius)
        self.layer.borderWidth  = CGFloat(CardConstant.border.width)
        self.layer.borderColor  = UIColor.cardBorderColor.cgColor
        self.applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        self.card = Card(number: 0)
        super.init(coder: coder)
        fatalError("Init coder")
    }
    
    var card: Card {
        didSet {
            self.updateCardDesign()
        }
    }
    
    fileprivate func updateCardDesign() {
        if card.state == .Close {
            flipRightAnimation { [weak self] in
                guard let self = self else { return }
                self.numberLabel.text = "💢"
                self.backgroundColor = .cardBackgroundColorClose
                self.numberLabel.textColor = .cardLabelTextColorClose
            }
        } else {
            flipLeftAnimation { [weak self] in
                guard let self = self else { return }
                self.numberLabel.text = "\(self.card.number)"
                self.backgroundColor = .cardBackgroundColorOpen
                self.numberLabel.textColor = .cardLabelTextColorOpen
            }
        }
    }
    
    fileprivate func applyConstraints() {
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[numberLabel]-|", options: [], metrics: nil, views: ["numberLabel" : numberLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[numberLabel]-|", options: [], metrics: nil, views: ["numberLabel" : numberLabel]))
        backgroundColor = .cardBackgroundColorClose
    }
    
}
