//
//  PlanetDetailsViewController.swift
//  SolarSystem
//
//  Created by Neha Thakore on 11/7/17.
//  Copyright © 2017 Neha Thakore. All rights reserved.
//

import UIKit

enum PlanetMediaTableViewRow: Int {
    case planetMediaImages
    case planetMediaVideos
}

class PlanetDetailsViewController: UIViewController {
    
    @IBOutlet weak var planetImageView: UIImageView!
    @IBOutlet weak var planetInfoLabel: UILabel!
    @IBOutlet weak var planetMediaTableView: UITableView!
    
    fileprivate weak var imagesCollectionView: UICollectionView?
    fileprivate weak var videosCollectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetMediaTableView.delegate = self
        planetMediaTableView.dataSource = self
        
        // Remove extra separators
        planetMediaTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
}

extension PlanetDetailsViewController: UITableViewDelegate {
}

extension PlanetDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetMediaTableViewCell") as? PlanetMediaTableViewCell,
            let section = PlanetMediaTableViewRow(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        
        switch section {
        case .planetMediaImages:
            imagesCollectionView = cell.planetMediaCollectionView
        case .planetMediaVideos:
            videosCollectionView = cell.planetMediaCollectionView
        }
        cell.planetMediaCollectionView.delegate = self
        cell.planetMediaCollectionView.dataSource = self
        return cell
    }
}

extension PlanetDetailsViewController: UICollectionViewDelegate {
}

extension PlanetDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imagesCollectionView {
            return 5
        } else if collectionView == videosCollectionView {
            return 3
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetMediaCollectionViewCell", for: indexPath) as? PlanetMediaCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if collectionView == imagesCollectionView {
            cell.imageView.image = UIImage(named: "cat")
        }
        if collectionView == videosCollectionView {
            cell.imageView.image = UIImage(named: "dog")
        }
        return cell
    }
}
