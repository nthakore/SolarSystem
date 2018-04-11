//
//  CollectionViewController.swift
//  SolarSystem
//
//  Created by Neha Thakore on 11/6/17.
//  Copyright © 2017 Neha Thakore. All rights reserved.
//

import UIKit

class PlanetsCollectionViewController: UIViewController {
    @IBOutlet weak var planetsCollectionView: UICollectionView!
    
    fileprivate var itemsForCollectionView: [Planet] = [.mercury, .venus, .earth, .mars, .jupiter, .saturn, .uranus, .neptune]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetsCollectionView.dataSource = self
        planetsCollectionView.delegate = self
    }
}

extension PlanetsCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsController = storyboard.instantiateViewController(withIdentifier: "PlanetDetailsViewController") as? PlanetDetailsViewController {
            let planet = itemsForCollectionView[indexPath.item]
            detailsController.currentPlanet = planet
            present(detailsController, animated: true, completion: nil)
        }
    }
}

extension PlanetsCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsForCollectionView.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetsCollectionViewCell", for: indexPath) as? PlanetsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let planet = itemsForCollectionView[indexPath.item]
        cell.planetNameLabel.text = planet.displayName
        cell.planetImage.image = planet.planetImage
        
        return cell
    }
}
