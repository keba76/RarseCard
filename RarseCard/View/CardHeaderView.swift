//
//  CardHeaderView.swift
//  RarseCard
//
//  Created by Ievgen Keba on 2/6/17.
//  Copyright © 2017 Harman Inc. All rights reserved.
//

import UIKit

class CardHeaderView: UIView {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var cardDescriptionLbl: UILabel!
    @IBOutlet weak var numberOfComentsLbl: UILabel!
    
    var card: IntItem? {
        didSet {
            backgroundImageView.image = card?.cars.image
            cardDescriptionLbl.text = card?.cars.description
            numberOfComentsLbl.text = "\(card?.cars.numberOfComments) comments"
        }
        
    }
    
}
