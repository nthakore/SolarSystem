//
//  PlanetMediaCollectionViewCell.swift
//  SolarSystem
//
//  Created by Neha Thakore on 11/7/17.
//  Copyright © 2017 Neha Thakore. All rights reserved.
//

import UIKit
import Nuke

typealias PlanetImageCellModel = (imageURL: String, imageCaption: String)
typealias PlanetVideoCellModel = (thumbnailURL: String, planetVideoURL: String)

class PlanetMediaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var playArrowImageView: UIImageView!
    
    var videoURLString: String?
    var imageURLString: String? {
        didSet {
            if let urlString = imageURLString, let imageURL = URL(string: urlString) {
                Manager.shared.loadImage(with: imageURL, into: imageView)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let sideLength = contentView.frame.size.width
        contentView.layer.cornerRadius = sideLength / 4.0
        contentView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
