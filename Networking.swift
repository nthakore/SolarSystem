//
//  Networking.swift
//  SolarSystem
//
//  Created by Neha Thakore on 11/15/17.
//  Copyright © 2017 Neha Thakore. All rights reserved.
//

import UIKit

class Networking: NSObject {
    static func executeDataTask(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let d = data {
                if let foundationObject = try? JSONSerialization.jsonObject(with: d, options: []) {
                    print(foundationObject)
                }
            }
        }
        task.resume()
    }
}
