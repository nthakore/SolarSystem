//
//  NASA.swift
//  SolarSystem
//
//  Created by Neha Thakore on 11/15/17.
//  Copyright © 2017 Neha Thakore. All rights reserved.
//

import UIKit

class NASAAPI: NSObject {
    fileprivate static let baseURL = "https://images-api.nasa.gov/search?"
    
    
    static func fetchVideosForPlanet(planet: String, fetchCompletionHandler: (([PlanetVideoCellModel]) -> Void)?) {
        let urlString = NASAAPI.baseURL + "q=\(planet)&media_type=video"
        
        if let url = URL(string: urlString) {
            Networking.executeDataTask(url: url, networkCompletionHandler: { (responseObject) in
                if let object = responseObject as? [String: AnyObject], let collectionDict = object["collection"] as? [String: AnyObject] {
                    if let itemsArray = collectionDict["items"] as? [[String: AnyObject]] {
                        var numberOfItems = 5
                        var planetVideoModel: PlanetVideoCellModel = ("", "")
                        var planetVideos = [PlanetVideoCellModel]()
                        for item in itemsArray[0...4] {
                            if let assetCollectionURLString = item["href"] as? String {
                                if let encodedAssetCollectionURLString = assetCollectionURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let assetURL = URL(string: encodedAssetCollectionURLString) {
                                    Networking.executeDataTask(url: assetURL, networkCompletionHandler: { (assetsObject) in
                                        if let videoLinks = assetsObject as? [String] {
                                            for link in videoLinks {
                                                if link.range(of: "small.mp4") != nil {
                                                    if let encodedURL = link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                                                       planetVideoModel.planetVideoURL = encodedURL
                                                    }
                                                }
                                                if link.range(of: "small_thumb_00002.png") != nil {
                                                    if let encodedURL = link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                                                        planetVideoModel.thumbnailURL = encodedURL
                                                    }
                                                }
                                            }
                                            planetVideos.append(planetVideoModel)
                                            numberOfItems -= 1
                                            if numberOfItems == 0 {
                                                fetchCompletionHandler?(planetVideos)
                                            }
                                        }
                                    })
                                }
                            }
                        }
                    }
                }
            })
        }
    }
    
    static func fetchPhotosForPlanet(planet: String, fetchCompletionHandler: (([PlanetImageCellModel]) -> Void)?) {
        let urlString = NASAAPI.baseURL + "q=\(planet)&media_type=image"
        
        if let url = URL(string: urlString) {
            Networking.executeDataTask(url: url, networkCompletionHandler: { (responseObject) in
                if let object = responseObject as? [String: AnyObject], let collectionDict = object["collection"] as? [String: AnyObject] {
                    if let itemsArray = collectionDict["items"] as? [[String: AnyObject]] {
                        
                        var planetImages = [PlanetImageCellModel]()
                        
                        for item in itemsArray[0...24] {
                            if let links = item["links"] as? [[String: AnyObject]], let data = item["data"] as? [[String: AnyObject]] {
                                if let link = links.first, let dataPoints = data.first {
                                    if let imageURL = link["href"] as? String, let imageDescription = dataPoints["description"] as? String {
                                        planetImages.append((imageURL, imageDescription))
                                    }
                                }
                            }
                        }
                        fetchCompletionHandler?(planetImages)
                    }
                }
            })
            
        }
    }
}
