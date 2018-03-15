//
//  UIView+Extensions.swift
//  SolarSystem
//
//  Created by Neha Thakore on 3/14/18.
//  Copyright © 2018 Neha Thakore. All rights reserved.
//

import UIKit
import AVFoundation

extension UIView {
    func addVideoLayer(fileName: String, fileExtension: String) {
        if let path = Bundle.main.path(forResource: fileName, ofType: fileExtension),
            let pathURL = URL(string: path) {
            let player = AVPlayer(url: pathURL)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = bounds
//            playerLayer.position = CGPoint.zero
            playerLayer.videoGravity = .resizeAspectFill
            playerLayer.repeatCount = .infinity
//            layer.addSublayer(playerLayer)
            layer.insertSublayer(playerLayer, at: 0)
            player.play()
        }
    }
}

