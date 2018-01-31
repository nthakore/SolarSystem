//
//  Pages.swift
//  SolarSystem
//
//  Created by Neha Thakore on 11/16/17.
//  Copyright © 2017 Neha Thakore. All rights reserved.
//

import Foundation

struct Pages: Codable {
    var page: PageNumber
    
    enum CodingKeys: String, CodingKey {
        case page
    }
}

struct GenericCodingKeys: CodingKey {
    var intValue: Int?
    var stringValue: String
    
    init?(intValue: Int) { self.intValue = intValue; self.stringValue = "\(intValue)" }
    init?(stringValue: String) { self.stringValue = stringValue }
}

extension Pages {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: GenericCodingKeys.self)
        page = try values.decode(PageNumber.self, forKey: values.allKeys.first!)
    }
}
