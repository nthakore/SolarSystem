//
//  PlanetDetailsViewController.swift
//  SolarSystem
//
//  Created by Neha Thakore on 11/7/17.
//  Copyright © 2017 Neha Thakore. All rights reserved.
//

import UIKit

enum PlanetMediaTableViewRow: Int {
    case planetImage
    case planetInfo
    case planetMediaImages
    case planetMediaVideos
    
    static var count: Int {
        return PlanetMediaTableViewRow.planetMediaVideos.hashValue + 1
    }
}

class PlanetDetailsViewController: UIViewController {
    @IBOutlet weak var planetMediaTableView: UITableView!
    
    var currentPlanet: Planet?
    var planetInfoText: String?
    var transitionView: UIView?
    
    fileprivate weak var imagesCollectionView: UICollectionView?
    fileprivate weak var videosCollectionView: UICollectionView?
    fileprivate var imageCellModels = [PlanetImageCellModel]()
    fileprivate var videoCellModels = [PlanetVideoCellModel]()
    fileprivate var previousScrollViewContentOffset = CGFloat(0)
    fileprivate var didSetInitialTableViewOffset = false
    


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
        
        if let planet = currentPlanet {
            WikipediaAPI.fetchInfoForPlanet(planet: planet) { [weak self] (planetInfoText) in
                DispatchQueue.main.async {
                    self?.planetInfoText = planetInfoText
                    self?.planetMediaTableView.reloadData()
                }
            }
            NASAAPI.fetchPhotosForPlanet(planet: planet) { [weak self] (planetImages) in
                self?.imageCellModels = planetImages
                DispatchQueue.main.async {
                    self?.imagesCollectionView?.reloadData()
                }
            }
            NASAAPI.fetchVideosForPlanet(planet: planet) { [weak self] (planetVideos) in
                self?.videoCellModels = planetVideos
                DispatchQueue.main.async {
                    self?.videosCollectionView?.reloadData()
                }
            }
        }
    }
}

extension PlanetDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let row = PlanetMediaTableViewRow(rawValue: indexPath.row) {
            switch row {
            case .planetInfo:
                let storyboard = UIStoryboard(name: "Details", bundle: nil)
                if let infoController = storyboard.instantiateViewController(withIdentifier: "PlanetInfoViewController") as? PlanetInfoViewController {
                    infoController.planetInfo = planetInfoText
                    present(infoController, animated: true, completion: nil)
                }
            default:
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let defaultHeight = CGFloat(150)
        if let row = PlanetMediaTableViewRow(rawValue: indexPath.row) {
            switch row {
            case .planetImage:
                return tableView.frame.size.height * 0.6
            case .planetInfo:
                return defaultHeight + 150
            default:
                return defaultHeight
            }
        }
        return defaultHeight
    }
}

extension PlanetDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlanetMediaTableViewRow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = PlanetMediaTableViewRow(rawValue: indexPath.row) else {
            return UITableViewCell()
        }
        
        var tableViewCell = UITableViewCell()
        
        switch row {
        case .planetImage:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetImageTableViewCell") as? PlanetImageTableViewCell {
                cell.planetBackgroundImageView.image = currentPlanet?.planetBackgroundImage
                cell.planetImageView.image = currentPlanet?.planetImage
                cell.planetNameLabel.text = currentPlanet?.displayName.uppercased()
                cell.planetNameLabel.addKerning(value: 5)
                
                transitionView = cell
                
                tableViewCell = cell
            }
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
            cell.playArrowImageView.alpha = 0.7
            cell.playArrowImageView.image = UIImage(named: "Play Button")
        }
        return cell
    }
}
