//
//  planetsCollectionViewCell.swift
//  SolarSystem
//
//  Created by Neha Thakore on 11/6/17.
//  Copyright © 2017 Neha Thakore. All rights reserved.
//

import UIKit

class PlanetsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var planetNameLabel: UILabel!
    @IBOutlet weak var planetImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let sideLength = contentView.frame.size.width
        contentView.layer.cornerRadius = sideLength / 8.0
        contentView.layer.masksToBounds = true
    }
}
