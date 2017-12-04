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
    
    static func fetchVideosForPlanet(planet: String) {
        let urlString = NASAAPI.baseURL + "q=\(planet)&media_type=video"
        
        if let url = URL(string: urlString) {
            Networking.executeDataTask(url: url, networkCompletionHandler: { (responseObject) in
                if let object = responseObject, let collectionDict = object["collection"] as? [String: AnyObject] {
                    if let itemsArray = collectionDict["items"] as? [[String: AnyObject]] {
                        for item in itemsArray {
                            if let videoThumbnailsOptions = item["href"] as? String {
                                
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
                if let object = responseObject, let collectionDict = object["collection"] as? [String: AnyObject] {
                    if let itemsArray = collectionDict["items"] as? [[String: AnyObject]] {
                        
                        var planetImages = [PlanetImageCellModel]()
                        
                        for item in itemsArray {
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
