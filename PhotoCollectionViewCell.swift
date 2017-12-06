//
//  PhotoCollectionViewCell.swift
//  SolarSystem
//
//  Created by Neha Thakore on 11/8/17.
//  Copyright © 2017 Neha Thakore. All rights reserved.
//

import UIKit
import Nuke

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageDescription: UILabel!
    var cellModel: PlanetImageCellModel? {
        didSet {
            setDisplayValues()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageDescription.text = nil
    }
    
    func setDisplayValues() {
        guard let model = cellModel else {
            return
        }
        
        if let url = URL(string: model.imageURL) {
            Manager.shared.loadImage(with: url, into: imageView)
        }
        
        imageDescription.text = model.imageCaption
    }
}
