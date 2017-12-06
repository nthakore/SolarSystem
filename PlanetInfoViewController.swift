//
//  PlanetInfoViewController.swift
//  SolarSystem
//
//  Created by Neha Thakore on 12/6/17.
//  Copyright © 2017 Neha Thakore. All rights reserved.
//

import UIKit

class PlanetInfoViewController: UIViewController {
    @IBOutlet weak var planetInfoTextView: UITextView!
    var planetInfo: String?
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planetInfoTextView.text = planetInfo
    }
}
