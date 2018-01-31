//
//  Query.swift
//  SolarSystem
//
//  Created by Neha Thakore on 12/11/17.
//  Copyright © 2017 Neha Thakore. All rights reserved.
//

import Foundation

struct Query: Codable {
    var normalized: [NormalizedQuery]
    var pages: Pages
}
