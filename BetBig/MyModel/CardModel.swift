//
//  CardModel.swift
//  Match Mania Lite App
//
//  Created by Jaykrushna Solanki on 04/02/20.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//  Skype Id : jaykrushna.solanki
//

import Foundation

class CardModel
{
    func getCards() -> [Card]
    {
        var arrAllCards = [Card]()
        let arrNum = [2,3,4,5,6,7,8,9,10,11,12,13,14]
        
        //FOR CLUB
        for i in 0..<13 {
            let card = Card()
            card.imageName = "clubs-\(arrNum[i])"
            card.isFlipped = false
            arrAllCards.append(card)
        }
        
        //FOR DIAMOND
        for i in 0..<13 {
            let card = Card()
            card.imageName = "diamonds-\(arrNum[i])"
            card.isFlipped = false
            arrAllCards.append(card)
        }
        
        //FOR SPADE
        for i in 0..<13 {
            let card = Card()
            card.imageName = "spades-\(arrNum[i])"
            card.isFlipped = false
            arrAllCards.append(card)
        }
        
        //FOR HEART
        for i in 0..<13 {
            let card = Card()
            card.imageName = "hearts-\(arrNum[i])"
            card.isFlipped = false
            arrAllCards.append(card)
        }
        
        
        return arrAllCards
    }
    
    func getAllCards(legnth : Int?) -> [Card] {
        
        return Array(getCards().shuffled().shuffled().shuffled().shuffled().shuffled().prefix(legnth!))
    }
    
    func getUniqeCards() -> Card {
        
        return Array(getCards().shuffled().shuffled().shuffled().shuffled().shuffled()).randomElement()!
    }
}
