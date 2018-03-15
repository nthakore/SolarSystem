//
//  CollectionViewController.swift
//  SolarSystem
//
//  Created by Neha Thakore on 11/6/17.
//  Copyright © 2017 Neha Thakore. All rights reserved.
//

import UIKit
import AVKit

class PlanetsCollectionViewController: UIViewController {
    @IBOutlet weak var planetsCollectionView: UICollectionView!
    @IBOutlet weak var videoView: UIView!
    
    fileprivate var itemsForCollectionView: [Planet] = [.mercury, .venus, .earth, .mars, .jupiter, .saturn, .uranus, .neptune]
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var playerItem: AVPlayerItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetsCollectionView.dataSource = self
        planetsCollectionView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playVideoLayer(fileName: "OnboardingVideo", fileExtension: "mp4")
    }
    
    func playVideoLayer(fileName: String, fileExtension: String) {
//        planetsCollectionView.isHidden = true
        videoView.backgroundColor = .red
        
        if let path = Bundle.main.path(forResource: fileName, ofType: fileExtension),
            let pathURL = URL(string: path) {
            player = AVPlayer(url: pathURL)
            
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = videoView.bounds
            playerLayer?.videoGravity = .resizeAspectFill
            playerLayer?.repeatCount = .infinity
            videoView.layer.insertSublayer(playerLayer!, at: 0)
            player?.play()
        }
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
        cell.planetImage.image = UIImage(named: "\(planet.displayName)")
        
        return cell
    }
}
