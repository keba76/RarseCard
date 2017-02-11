//
//  CardCell.swift
//  RarseCard
//
//  Created by Ievgen Keba on 2/6/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var titleCard: UILabel!
    @IBOutlet weak var descript: UILabel!
    
    var card: IntItem? {
        didSet {
            cardImage.image = card?.cars.image
            titleCard.text = card?.cars.name
            descript.text = card?.cars.description
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        
    }
}
