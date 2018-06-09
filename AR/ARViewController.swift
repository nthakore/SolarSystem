//
//  ViewController.swift
//  SolarSystem
//
//  Created by Neha Thakore on 11/6/17.
//  Copyright © 2017 Neha Thakore. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var solarSystemNode: SCNNode?
    
    let durationDict: [String: TimeInterval] = ["mercuryParentNode": 1.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(recognizer:)))
        sceneView.addGestureRecognizer(pinchGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        
        
        if let solarSystemScene = SCNScene(named: "SceneKit Scene.scn") {
            if let solarSystemParentNode = solarSystemScene.rootNode.childNode(withName: "solarSystem", recursively: false) {
                sceneView.scene.rootNode.addChildNode(solarSystemParentNode)
                solarSystemParentNode.position = SCNVector3(0, 0, -2.0)
                solarSystemNode = solarSystemParentNode
                
                for node in solarSystemParentNode.childNodes {
                    if let planet = Planet(planetParentNodeName: node.name) {
                        let orbitRotationAction = SCNAction.rotateBy(x: 0, y: .pi, z: 0, duration: planet.orbitDuration)
                        let orbitRotateForeverAction = SCNAction.repeatForever(orbitRotationAction)
                        node.runAction(orbitRotateForeverAction)
                        
                        let planetRotationAction = SCNAction.rotateBy(x: 0, y: .pi, z: 0, duration: planet.planetRotationDuration)
                        let planetRotateForeverAction = SCNAction.repeatForever(planetRotationAction)
                        node.childNodes.first?.runAction(planetRotateForeverAction)

                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    @objc func handlePinch(recognizer: UIPinchGestureRecognizer) {
        if let node = solarSystemNode {
            if recognizer.state == .changed {
                let pinchScaleX = Float(recognizer.scale) * node.scale.x
                let pinchScaleY = Float(recognizer.scale) * node.scale.y
                let pinchScaleZ = Float(recognizer.scale) * node.scale.z
                node.scale = SCNVector3(pinchScaleX, pinchScaleY, pinchScaleZ)
                recognizer.scale = 1
            }
        }
    }
}

extension Planet {
    init?(planetParentNodeName: String?) {
        switch planetParentNodeName {
        case "mercuryParentNode":
            self = .mercury
        case "venusParentNode":
            self = .venus
        case "earthParentNode":
            self = .earth
        case "marsParentNode":
            self = .mars
        case "jupiterParentNode":
            self = .jupiter
        case "saturnParentNode":
            self = .saturn
        case "uranusParentNode":
            self = .uranus
        case "neptuneParentNode":
            self = .neptune
        default:
            return nil
        }
    }
    
    var orbitDuration: TimeInterval {
        switch self {
        case .mercury:
            return 12
        case .venus:
            return 15
        case .earth:
            return 18
        case .mars:
            return 21
        case .jupiter:
            return 24
        case .saturn:
            return 27
        case .uranus:
            return 30
        case .neptune:
            return 33
        }
    }
    
    var planetRotationDuration: TimeInterval {
        switch self {
        case .mercury:
            return 1
        case .venus:
            return 2
        case .earth:
            return 3
        case .mars:
            return 4
        case .jupiter:
            return 5
        case .saturn:
            return 6
        case .uranus:
            return 7
        case .neptune:
            return 8
        }
    }
}

