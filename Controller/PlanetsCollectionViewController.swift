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
    let transition = PopAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetsCollectionView.dataSource = self
        planetsCollectionView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        print("\(self.view.frame)")
    }
}

extension PlanetsCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rect = collectionView.cellForItem(at: indexPath)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsController = storyboard.instantiateViewController(withIdentifier: "PlanetDetailsViewController") as? PlanetDetailsViewController {
            let planet = itemsForCollectionView[indexPath.item]
            detailsController.currentPlanet = planet
            detailsController.transitioningDelegate = self
            transition.originFrame = rect!.superview!.convert(rect!.frame, to: nil)
            transition.presenting = true
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
        let planetNameString = planet.displayName.uppercased()
        let attributedString = NSMutableAttributedString(string: planetNameString)
        attributedString.addAttribute(NSAttributedStringKey.kern, value: 5, range: NSRange(location: 0, length: attributedString.length - 1))
        
        cell.planetNameLabel.attributedText = attributedString
        cell.planetImage.image = planet.planetImage
        cell.backgroundImage.image = planet.planetBackgroundImage
        
        return cell
    }
}

extension PlanetsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {        
        let sideMargin = CGFloat(16)
        let collectionViewSize = collectionView.frame.size
        let cellWidth = collectionViewSize.width - 2.0 * sideMargin
        let cellHeight = collectionViewSize.height * 0.6
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension PlanetsCollectionViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}
