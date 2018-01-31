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
    
    static func fetchInfoForPlanet(planet: String, fetchCompletionHandler: ((String?) -> Void)?) {
        let urlString = WikipediaAPI.baseURL + "action=query&format=json&titles=\(planet)%20&prop=extracts&exintro&explaintext"
        
        if let url = URL(string: urlString) {
            Networking.executeDataTask(url: url, networkCompletionHandler: { (responseObject) in
                if let object = responseObject as? [String: AnyObject], let queryDict = object["query"] as? [String: AnyObject] {
                    if let pagesDict = queryDict["pages"] as? [String: AnyObject] {
                        if let pageKey = pagesDict.keys.first, let pageNumberDict = pagesDict[pageKey] as? [String: AnyObject] {
                            if let extractText = pageNumberDict["extract"] as? String {
                                fetchCompletionHandler?(extractText)
                            }
                        }
                    }
                }
            })
        }
    }
    
    static func fetchTestInfoForPlanet(planet: String, fetchCompletionHandler: ((String?) -> Void)?) {
        let urlString = WikipediaAPI.baseURL + "action=query&format=json&titles=\(planet)%20&prop=extracts&exintro&explaintext"
        
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
