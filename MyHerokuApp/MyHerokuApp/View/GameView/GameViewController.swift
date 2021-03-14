//
//  GameViewController.swift
//  MyHerokuApp
//
//  Created by Varun Mehta on 13/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    //Card Collection View
   fileprivate let cardCollection: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView:UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardView.self, forCellWithReuseIdentifier: GameConstants.CardViewStrings.CARD_CELL_IDENTIFIER)
    collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    //Reset Button
    fileprivate let resetButton: UIButton = {
        let button:UIButton = UIButton()
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(GameConstants.GameViewStrings.RESET_BTN_LABEL, for: UIControl.State.normal)
        return button
    }()
    
    //Step Count Label
    fileprivate let stepCountLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(format: GameConstants.GameViewStrings.STEP_COUNT_LABEL, 0)
        label.textColor = .scoreColor
        label.textAlignment = .right
        label.font = .H3_BOLD
        return label
    } ()
    
    var viewModel:GameViewModel? {
        didSet {
            updateUI()
        }
    }
    //MARK:- Life Cycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        updateStyle()
        updateUI()
    }
    
    //MARK:- Private Methods -
    fileprivate func updateStyle() {
        
        //Collection View
        self.view.addSubview(cardCollection)
        self.view.addSubview(resetButton)
        self.view.addSubview(stepCountLabel)
        
        self.cardCollection.backgroundColor = .gameBackgroundColor
        
        self.cardCollection.delegate   = self
        self.cardCollection.dataSource = self
        
        self.applyConstraints()
        
    }
    
    fileprivate func applyConstraints() {
        let viewsDict = ["cardCollection":cardCollection, "resetButton":resetButton, "stepCountLabel":stepCountLabel]
        let metricsDict = ["buttonHeight": 44, "buttonWidth":200]
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[resetButton(buttonWidth)]-[stepCountLabel]-|", options: [], metrics: metricsDict, views: viewsDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[cardCollection]-|", options: [], metrics: nil, views: viewsDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[resetButton(buttonHeight)]-[cardCollection]-|", options: [], metrics: metricsDict, views: viewsDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[stepCountLabel(buttonHeight)]-[cardCollection]-|", options: [], metrics: metricsDict, views: viewsDict))

    }
    
    fileprivate func updateUI() {
        guard let _ = viewModel else {
            return
        }
        self.cardCollection.reloadData()
    }
}
