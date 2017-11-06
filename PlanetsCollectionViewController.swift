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
    
    fileprivate var resultsForCollectionView = [PlanetDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetsCollectionView.dataSource = self
        planetsCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        for index in 0...20 {
            let result = PlanetDetails(planetName: "\(index)")
            resultsForCollectionView.append(result)
        }
    }
}

extension PlanetsCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

    }
}

extension PlanetsCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultsForCollectionView.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetsCollectionViewCell", for: indexPath) as? PlanetsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        print("indexPath: \(indexPath)")
        
        let details = resultsForCollectionView[indexPath.row]
        cell.planetNameLabel.text = details.planetName
        
        return cell
    }
}
