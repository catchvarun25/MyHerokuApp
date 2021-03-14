//
//  GameViewDataSource.swift
//  MyHerokuApp
//
//  Created by Varun Mehta on 13/3/21.
//  Copyright © 2021 Varun Mehta. All rights reserved.
//

import UIKit

extension GameViewController:UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let gameModel = self.viewModel?.game else {
            return 0
        }
        return gameModel.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CardView = collectionView.dequeueReusableCell(withReuseIdentifier: GameConstants.CardViewStrings.CARD_CELL_IDENTIFIER, for: indexPath) as! CardView
        cell.card = self.viewModel?.game.cards[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let game = self.viewModel?.game else {
            return
        }
        //Selected Card
        let selectedCard = game.cards[indexPath.row]
        
        //Open card if closed else don't do anything
        guard selectedCard.state == .Close else {
            return
        }
        self.viewModel?.updateCardStateTo(.Open, forCardAt: indexPath.row)
        collectionView.reloadItems(at: [indexPath])
    }

}

extension GameViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3 - 10, height: collectionView.frame.size.height/4)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }


}
