//
//  CALayer+Extension.swift
//  CineVerse
//
//  Created by chandru-13685 on 02/04/24.
//

import Foundation
import UIKit

extension CALayer {
    func applyShadow(
        color: UIColor = .black,
        opacity: Float = 0.5,
        offset: CGSize = CGSize(width: 0, height: 2),
        radius: CGFloat = 4,
        cornerRadius: CGFloat = 0
    ) {
        
        self.masksToBounds = false
        self.shadowColor = color.cgColor
        self.shadowOpacity = opacity
        self.shadowOffset = offset
        self.shadowRadius = radius
        
        if cornerRadius > 0 {
            self.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        } else {
            self.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        }
        
        self.shouldRasterize = true
        self.rasterizationScale = UIScreen.main.scale
    }
}
