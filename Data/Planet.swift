//
//  Planet.swift
//  SolarSystem
//
//  Created by Neha Thakore on 2/7/18.
//  Copyright © 2018 Neha Thakore. All rights reserved.
//

import Foundation
import UIKit

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
    
    var planetImage: UIImage {
        switch self {
        case .mercury:
            return #imageLiteral(resourceName: "Mercury")
        case .venus:
            return #imageLiteral(resourceName: "Venus")
        case .earth:
            return #imageLiteral(resourceName: "Earth")
        case .mars:
            return #imageLiteral(resourceName: "Mars")
        case .jupiter:
            return #imageLiteral(resourceName: "Jupiter")
        case .saturn:
            return #imageLiteral(resourceName: "Saturn")
        case .uranus:
            return #imageLiteral(resourceName: "Uranus")
        case .neptune:
            return #imageLiteral(resourceName: "Neptune")
        }
    }
}
