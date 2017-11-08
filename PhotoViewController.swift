//
//  PhotoViewController.swift
//  SolarSystem
//
//  Created by Neha Thakore on 11/8/17.
//  Copyright © 2017 Neha Thakore. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var photoCollectionView: UICollectionView!
}

extension PhotoViewController: UICollectionViewDelegate {
}

extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.imageView.image = UIImage(named: "cat")
        return cell
    }
}
