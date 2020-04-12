//
//  Extensions.swift
//  CountriesTask
//
//  Created by Amr Mohamed on 4/12/20.
//  Copyright © 2020 amr. All rights reserved.
//

import UIKit

// Rotating Arrow shape
extension UIView {
    func rotate() {
        self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
}
