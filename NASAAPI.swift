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
            Networking.executeDataTask(url: url)
        }
    }
    
    static func fetchPhotosForPlanet(planet: String) {
        let urlString = NASAAPI.baseURL + "q=\(planet)&media_type=image"
        
        if let url = URL(string: urlString) {
            Networking.executeDataTask(url: url)
        }
    }
}
