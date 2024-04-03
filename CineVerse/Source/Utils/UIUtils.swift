//
//  UIUtils.swift
//  CineVerse
//
//  Created by chandru-13685 on 01/04/24.
//

import Foundation
import UIKit

enum FadeSide {
    case top
    case bottom
    case left
    case right
}

enum UIUtils {
    
    static func fade(imageView: UIImageView, side: FadeSide) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = imageView.bounds
        
        var startPoint: CGPoint
        var endPoint: CGPoint
        
        switch side {
        case .top:
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            startPoint = CGPoint(x: 0.5, y: 0.0)
            endPoint = CGPoint(x: 0.5, y: 0.2)
        case .bottom:
            gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
            startPoint = CGPoint(x: 0.5, y: 0.8)
            endPoint = CGPoint(x: 0.5, y: 1.0)
        case .left:
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            startPoint = CGPoint(x: 0.0, y: 0.5)
            endPoint = CGPoint(x: 0.2, y: 0.5)
        case .right:
            gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
            startPoint = CGPoint(x: 0.8, y: 0.5)
            endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        imageView.layer.mask = gradientLayer
    }
    
}
