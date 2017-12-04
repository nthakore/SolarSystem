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
    fileprivate var imageCellModels = [PlanetImageCellModel]()
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        planetMediaTableView.delegate = self
        planetMediaTableView.dataSource = self
        
        // Remove extra separators
        planetMediaTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        WikipediaAPI.fetchInfoForPlanet(planet: "Earth") { [weak self] (planetInfoText) in
            DispatchQueue.main.async {
//                self?.planetInfoLabel.text = planetInfoText
            }
        }
        NASAAPI.fetchPhotosForPlanet(planet: "Mars") { [weak self] (planetImages) in
            self?.imageCellModels = planetImages
            DispatchQueue.main.async {
                self?.imagesCollectionView?.reloadData()
            }
        }
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == imagesCollectionView {
            let storyboard = UIStoryboard(name: "Details", bundle: nil)
            if let photosController = storyboard.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController {
                photosController.startingIndexPath = indexPath
                photosController.imageCellModels = imageCellModels
                present(photosController, animated: true, completion: nil)
            }
        } else if collectionView == videosCollectionView {
            guard let path = Bundle.main.path(forResource: "PlanetEarth", ofType: "mp4") else {
                debugPrint("PlanetEarth.mp4 not found")
                return
            }
            Video.playVideoWithURLAndPresentingViewController(url: URL(fileURLWithPath: path), viewController: self)
        }
    }
}

extension PlanetDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imagesCollectionView {
            return imageCellModels.count
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
            let cellModel = imageCellModels[indexPath.item]
            cell.imageURLString = cellModel.imageURL
        }
        
        if collectionView == videosCollectionView {
            cell.imageView.image = UIImage(named: "dog") 
        }
        return cell
    }
}
