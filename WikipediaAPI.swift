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
    
    static func fetchInfoForPlanet(planet: Planet, fetchCompletionHandler: ((String?) -> Void)?) {
        let urlString = WikipediaAPI.baseURL + "action=query&format=json&titles=\(planet.wikipediaSearchTerm)%20&prop=extracts&exintro&explaintext"
        
        if let url = URL(string: urlString) {
            Networking.executeTestDataTask(url: url, networkCompletionHandler: { (wikiResponse) in
                if let response = wikiResponse {
                    let extract = response.query.pages.page.extract
                    fetchCompletionHandler?(extract)
                } else {
                    fetchCompletionHandler?(nil)
                }
            })
        }
    }
}

fileprivate extension Planet {
    var wikipediaSearchTerm: String {
        switch self {
        case .mercury:
            return "Mercury_(planet)"
        case .venus:
            return "Venus"
        case .earth:
            return "Earth"
        case .mars:
            return "Mars"
        case .jupiter:
            return "Jupiter"
        case .saturn:
            return "Saturn"
        case .uranus:
            return "Uranus"
        case .neptune:
            return "Neptune"
        }
    }
}
