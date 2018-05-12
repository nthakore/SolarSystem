//
//  ViewController.swift
//  ARKitSampleApp
//
//  Created by Neha Thakore on 4/18/18.
//  Copyright © 2018 Neha Thakore. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ViewController: UIViewController {
    @IBOutlet weak var sceneView: ARSCNView!
    
    var solarSystemNode: SCNNode?
    
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
                
                let rotationAction = SCNAction.rotateBy(x: 0, y: .pi, z: 0, duration: 1)
                let rotateForeverAction = SCNAction.repeatForever(rotationAction)
                
                
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

extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}




