//
//  GameViewController.swift
//  MyHerokuApp
//
//  Created by Varun Mehta on 13/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import UIKit
import Combine

class GameViewController: UIViewController {
    private var disposeBag = Set<AnyCancellable>()

    //Card Collection View
    private(set) var cardCollection: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView:UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardView.self, forCellWithReuseIdentifier: Constants.CardView.Literals.CARD_CELL_IDENTIFIER)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    //Reset Button
    private(set) var resetButton: UIButton = {
        let button:UIButton = UIButton()
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.GameView.Literals.RESET_BTN_LABEL, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(resetGame), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    //Step Count Label
    private(set) var stepCountLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(format: Constants.GameView.Literals.STEP_COUNT_LABEL, 0)
        label.textColor = .scoreColor
        label.textAlignment = .right
        label.font = .H3_BOLD
        return label
    } ()
    
    private(set) var viewModel:GameViewModelProtocol

    
    init(model: GameViewModelProtocol) {
        self.viewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //MARK:- Life Cycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        updateStyle()
        bindPublisher()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator:UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.cardCollection.reloadData()
    }
    
    //MARK:- Target Methods -
    
    @objc func resetGame() {
        viewModel.resetGame()
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
    
    fileprivate func bindPublisher() {
        viewModel.stepCount.bind { [unowned self] in
            self.stepCountLabel.text = String(format: Constants.GameView.Literals.STEP_COUNT_LABEL, $0)
        }
        viewModel.isResetPublisher
            .receive(on: DispatchQueue.main, options: nil)
            .dropFirst()
            .sink { [unowned self] _ in
                self.cardCollection.reloadData()
            }
            .store(in: &disposeBag)
        viewModel.selectedCardIndexesPublisher
            .receive(on: DispatchQueue.main, options: nil)
            .dropFirst()
            .sink { [unowned self] indexes in
                let indexPaths = indexes.map{IndexPath(row: $0, section: 0)}
                self.cardCollection.reloadItems(at: indexPaths)
            }
            .store(in: &disposeBag)
        viewModel.isFinishedPublisher
            .receive(on: DispatchQueue.main, options: nil)
            .dropFirst()
            .sink { [unowned self] _ in
                self.showCongratsAlert()
            }
            .store(in: &disposeBag)
    }
    
    fileprivate func showCongratsAlert() {
        let congratsAlert = UIAlertController(
            title: Constants.AlertView.Congrats.TITLE,
            message: String(format: Constants.AlertView.Congrats.MESSAGE, self.viewModel.game.steps),
            preferredStyle: UIAlertController.Style.alert)
        let retryAction = UIAlertAction(title: Constants.AlertView.Congrats.TRY_AGAIN, style: UIAlertAction.Style.default) { _ in
            self.resetGame()
        }
        congratsAlert.addAction(retryAction)
        self.present(congratsAlert, animated: true, completion: nil)
    }
}
