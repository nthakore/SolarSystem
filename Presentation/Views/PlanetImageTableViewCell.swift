//
//  PlanetImageTableViewCell.swift
//  SolarSystem
//
//  Created by Neha Thakore on 6/9/18.
//  Copyright © 2018 Neha Thakore. All rights reserved.
//

import UIKit

class PlanetImageTableViewCell: UITableViewCell {

    @IBOutlet weak var planetBackgroundImageView: UIImageView!
    @IBOutlet weak var planetImageView: UIImageView!
    @IBOutlet weak var planetNameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        planetNameLabel.text = nil
        planetNameLabel.attributedText = nil
        planetBackgroundImageView.image = nil
        planetImageView.image = nil
    }
}
