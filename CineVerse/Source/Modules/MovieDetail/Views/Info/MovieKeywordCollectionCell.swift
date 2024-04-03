//
//  MovieKeywordCollectionCell.swift
//  CineVerse
//
//  Created by chandru-13685 on 03/04/24.
//

import UIKit


class MovieKeywordCollectionCell: UICollectionViewCell {
    
    static let identifier = "MovieKeywordCollectionCell"
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .quaternaryLabel
        layer.cornerRadius = 5
        label.addViewTo(contentView, topOffset: 5, leftOffset: 10, rightOffset: 10, bottomOffset: 5)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setKeywordText(with text: String) {
        label.text = text
    }
    
}
