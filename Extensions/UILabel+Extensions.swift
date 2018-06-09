//
//  UILabel+Extensions.swift
//  SolarSystem
//
//  Created by Neha Thakore on 6/9/18.
//  Copyright © 2018 Neha Thakore. All rights reserved.
//

import UIKit

extension UILabel {
    func addKerning(value: CGFloat) {
        if let labelText = text {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: value, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
