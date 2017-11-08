//
//  PlanetDetailsViewController.swift
//  SolarSystem
//
//  Created by Neha Thakore on 11/7/17.
//  Copyright © 2017 Neha Thakore. All rights reserved.
//

import UIKit

class PlanetDetailsViewController: UIViewController {
    
    @IBOutlet weak var planetImageView: UIImageView!
    @IBOutlet weak var planetInfoLabel: UILabel!
    @IBOutlet weak var planetMediaTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetMediaTableView.delegate = self
        planetMediaTableView.dataSource = self
    }
}

extension PlanetDetailsViewController: UITableViewDelegate {
}

extension PlanetDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetMediaTableViewCell") as? PlanetMediaTableViewCell else {
            return UITableViewCell()
        }
        cell.planetMediaCollectionView.delegate = self
        cell.planetMediaCollectionView.dataSource = self
        cell.planetMediaCollectionView.tag = indexPath.row
        cell.planetMediaCollectionView.reloadData()
        return cell
    }
}

extension PlanetDetailsViewController: UICollectionViewDelegate {
}

extension PlanetDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return 5
        }
        if collectionView.tag == 1 {
            return 3
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetMediaCollectionViewCell", for: indexPath) as? PlanetMediaCollectionViewCell else {
            return UICollectionViewCell()
        }
        print("indexPath: \(indexPath)")
        
        if collectionView.tag == 0 {
            cell.imageView.image = UIImage(named: "cat")
        }
        if collectionView.tag == 1 {
            cell.imageView.image = UIImage(named: "dog")
        }
        return cell
    }
}
