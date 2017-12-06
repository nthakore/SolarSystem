//
//  PlanetDetailsViewController.swift
//  SolarSystem
//
//  Created by Neha Thakore on 11/7/17.
//  Copyright © 2017 Neha Thakore. All rights reserved.
//

import UIKit

enum PlanetMediaTableViewRow: Int {
    case planetInfo
    case planetMediaImages
    case planetMediaVideos
}

class PlanetDetailsViewController: UIViewController {
    @IBOutlet weak var planetImageView: UIImageView!
    @IBOutlet weak var planetMediaTableView: UITableView!
    
    fileprivate var planetInfoText: String?
    fileprivate weak var imagesCollectionView: UICollectionView?
    fileprivate weak var videosCollectionView: UICollectionView?
    fileprivate var imageCellModels = [PlanetImageCellModel]()
    fileprivate var videoCellModels = [PlanetVideoCellModel]()
    
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
        WikipediaAPI.fetchInfoForPlanet(planet: "Mars") { [weak self] (planetInfoText) in
            DispatchQueue.main.async {
                self?.planetInfoText = planetInfoText
                self?.planetMediaTableView.reloadData()
            }
        }
        NASAAPI.fetchPhotosForPlanet(planet: "Mars") { [weak self] (planetImages) in
            self?.imageCellModels = planetImages
            DispatchQueue.main.async {
                self?.imagesCollectionView?.reloadData()
            }
        }
        NASAAPI.fetchVideosForPlanet(planet: "Mars") { [weak self] (planetVideos) in
            self?.videoCellModels = planetVideos
            DispatchQueue.main.async {
                self?.videosCollectionView?.reloadData()
            }
        }
    }
}

extension PlanetDetailsViewController: UITableViewDelegate {
}

extension PlanetDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = PlanetMediaTableViewRow(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        
        var tableViewCell = UITableViewCell()
        
        switch row {
        case .planetInfo:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetInfoTableViewCell") as? PlanetInfoTableViewCell {
                cell.planetInfoLabel.text = planetInfoText
                tableViewCell = cell
            }
        case .planetMediaImages:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetMediaTableViewCell") as? PlanetMediaTableViewCell {
                imagesCollectionView = cell.planetMediaCollectionView
                cell.planetMediaCollectionView.delegate = self
                cell.planetMediaCollectionView.dataSource = self
                tableViewCell = cell
            }
        case .planetMediaVideos:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetMediaTableViewCell") as? PlanetMediaTableViewCell {
                videosCollectionView = cell.planetMediaCollectionView
                cell.planetMediaCollectionView.delegate = self
                cell.planetMediaCollectionView.dataSource = self
                tableViewCell = cell
            }
        }
        return tableViewCell
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
            let cellModel = videoCellModels[indexPath.item]
            if let videoURL = URL(string: cellModel.planetVideoURL) {
                Video.playVideoWithURLAndPresentingViewController(url: videoURL, viewController: self)
            }
        }
    }
}

extension PlanetDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imagesCollectionView {
            return imageCellModels.count
        } else if collectionView == videosCollectionView {
            return videoCellModels.count
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
            let cellModel = videoCellModels[indexPath.item]
            cell.imageURLString = cellModel.thumbnailURL
        }
        return cell
    }
}
