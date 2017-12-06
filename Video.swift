//
//  Video.swift
//  SolarSystem
//
//  Created by Neha Thakore on 11/9/17.
//  Copyright © 2017 Neha Thakore. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class Video: NSObject {
    static func playVideoWithURLAndPresentingViewController(url: URL, viewController: UIViewController) {
        let player = AVPlayer(url: url)
        let controller = AVPlayerViewController()
        controller.player = player
        viewController.present(controller, animated: true) {
            player.play()
        }
    }
}
