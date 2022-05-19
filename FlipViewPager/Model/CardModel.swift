//
//  CardModel.swift
//  FlipViewPager
//
//  Created by AMIT on 5/19/22.
//

import Foundation

class CardModel {
    var id = ""
    var left: CardSubModel
    var right: CardSubModel
    
    init(id: String, left: CardSubModel, right: CardSubModel) {
        self.id = id
        self.left = left
        self.right = right
    }
}
