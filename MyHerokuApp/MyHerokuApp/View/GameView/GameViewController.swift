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
        collectionView.register(CardView.self, forCellWithReuseIdentifier: Constants.CardView.Literals.CARD_CELL_IDENTIFIER)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    //Reset Button
    fileprivate let resetButton: UIButton = {
        let button:UIButton = UIButton()
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.GameView.Literals.RESET_BTN_LABEL, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(resetGame), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    //Step Count Label
    fileprivate let stepCountLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(format: Constants.GameView.Literals.STEP_COUNT_LABEL, 0)
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
    
    override func viewWillTransition(to size: CGSize, with coordinator:UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.cardCollection.reloadData()
    }
    
    //MARK:- Target Methods -
    
    @objc func resetGame() {
        guard let model = viewModel else {
            return
        }
        model.resetGame()
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
        let metricsDict = ["buttonHeight": Constants.GameView.Design.RESET_BTN_HEIGHT, "buttonWidth":Constants.GameView.Design.RESET_BTN_WIDTH]
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[resetButton(buttonWidth)]-[stepCountLabel]-|", options: [], metrics: metricsDict, views: viewsDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[cardCollection]-|", options: [], metrics: nil, views: viewsDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[resetButton(buttonHeight)]-[cardCollection]-|", options: [], metrics: metricsDict, views: viewsDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[stepCountLabel(buttonHeight)]-[cardCollection]-|", options: [], metrics: metricsDict, views: viewsDict))
        
    }
    
    fileprivate func updateUI() {
        guard let gameModel = viewModel else {
            return
        }
        gameModel.stepCount.bind { [unowned self] in
            self.stepCountLabel.text = String(format: Constants.GameView.Literals.STEP_COUNT_LABEL, $0)
        }
        gameModel.isReset.bind { [unowned self] _ in
            self.cardCollection.reloadData()
        }
        gameModel.selectedCardIndex.bind({ [unowned self] (index) in
            self.cardCollection.reloadItems(at: [IndexPath(row: index, section: 0)])
        })
        gameModel.isFinished.bind { (isEnded) in
            if isEnded {
                self.showCongratsAlert()
            }
        }
    }
    
    fileprivate func showCongratsAlert() {
        let congratsAlert = UIAlertController(
            title: Constants.AlertView.Congrats.TITLE,
            message: String(format: Constants.AlertView.Congrats.MESSAGE, (self.viewModel?.game.steps)!),
            preferredStyle: UIAlertController.Style.alert)
        let retryAction = UIAlertAction(title: Constants.AlertView.Congrats.TRY_AGAIN, style: UIAlertAction.Style.default) { _ in
            self.resetGame()
        }
        congratsAlert.addAction(retryAction)
        self.present(congratsAlert, animated: true, completion: nil)
    }
}
