//
//  WikipediaAPI.swift
//  SolarSystem
//
//  Created by Neha Thakore on 11/15/17.
//  Copyright © 2017 Neha Thakore. All rights reserved.
//

import UIKit

class WikipediaAPI: NSObject {
    fileprivate static let baseURL = "https://en.wikipedia.org/w/api.php?"
    
    static func fetchInfoForPlanet(planet: String) {
        let urlString = WikipediaAPI.baseURL + "action=query&format=json&titles=\(planet)%20&prop=extracts&exintro&explaintext"
        
        if let url = URL(string: urlString) {
            Networking.executeDataTask(url: url)
        }
    }
    
}
