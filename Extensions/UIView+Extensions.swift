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
        if let path = Bundle.main.path(forResource: fileName, ofType: fileExtension) {
            let pathURL = URL(fileURLWithPath: path)
            let player = AVPlayer(url: pathURL)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = frame
            playerLayer.videoGravity = .resizeAspectFill
            layer.addSublayer(playerLayer)
            player.play()
            
            // Repeat animation forever
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main, using: { (notification) in
                player.seek(to: kCMTimeZero)
                player.play()
            })
        }
    }
}

