//
//  Networking.swift
//  SolarSystem
//
//  Created by Neha Thakore on 11/15/17.
//  Copyright © 2017 Neha Thakore. All rights reserved.
//

import UIKit

class Networking: NSObject {
    static func executeDataTask(url: URL, networkCompletionHandler: ((Any?) -> Void)?) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let d = data, let foundationObject = try? JSONSerialization.jsonObject(with: d, options: []) {
                    networkCompletionHandler?(foundationObject)
            } else {
                networkCompletionHandler?(nil)
            }
        }
        task.resume()
    }
    
    static func executeTestDataTask(url: URL, networkCompletionHandler: ((WikiResponse?) -> Void)?) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let d = data {
                let decoder = JSONDecoder()
                
                do {
                    let wikiResponse = try decoder.decode(WikiResponse.self, from: d)
                    networkCompletionHandler?(wikiResponse)
                } catch(let err as NSError) {
                    print("ERROR: \(err)")
                }
                
                if let wikiResponse = try? decoder.decode(WikiResponse.self, from: d) {
                    networkCompletionHandler?(wikiResponse)
                }
            } else {
                networkCompletionHandler?(nil)
            }
        }
        task.resume()
    }
}
