//
//  Planet.swift
//  SolarSystem
//
//  Created by Neha Thakore on 2/7/18.
//  Copyright © 2018 Neha Thakore. All rights reserved.
//

import Foundation

enum Planet {
    case mercury
    case venus
    case earth
    case mars
    case jupiter
    case saturn
    case uranus
    case neptune
    
    var displayName: String {
        switch self {
        case .mercury:
            return "Mercury"
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
