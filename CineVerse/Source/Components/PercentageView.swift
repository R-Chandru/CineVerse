//
//  PercentageView.swift
//  CineVerse
//
//  Created by chandru-13685 on 01/04/24.
//

import Foundation
import UIKit

class PercentageCircleView: UIView {
    
    var fontSize: CGFloat = 9
    var percentage: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var circleColor: UIColor {
        if percentage > 70 {
            return .green
        } else if percentage >= 40 {
            return .yellow
        } else {
            return .red
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2 - 10
        
        let backgroundPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        UIColor.black.setFill()
        backgroundPath.fill()
        
        let borderPath = UIBezierPath(arcCenter: center, radius: radius + 2, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        borderPath.lineWidth = 4
        UIColor.black.setStroke()
        borderPath.stroke()
        
        let endAngle = 2 * .pi * (percentage / 100) - (.pi / 2)
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -.pi / 2, endAngle: endAngle, clockwise: true)
        circlePath.lineWidth = 2
        circleColor.setStroke()
        circlePath.stroke()
        
        let remainingPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: endAngle, endAngle: -.pi / 2, clockwise: true)
        remainingPath.lineWidth = 2
        let colorWithAlpha = circleColor.withAlphaComponent(0.5)
        colorWithAlpha.setStroke()
        remainingPath.stroke()
        
        let percentageText = percentage > 0 ? "\(Int(percentage))%" : "NA"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: fontSize, weight: .semibold),
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.white
        ]
        let textSize = percentageText.size(withAttributes: attributes)
        let textRect = CGRect(x: center.x - textSize.width / 2, y: center.y - textSize.height / 2, width: textSize.width, height: textSize.height)
        percentageText.draw(in: textRect, withAttributes: attributes)
    }
}
