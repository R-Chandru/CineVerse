//
//  MovieListHeaderView.swift
//  CineVerse
//
//  Created by chandru-13685 on 29/03/24.
//

import UIKit

class MovieListHeaderView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    init(with title: String) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        backgroundColor = .systemBackground
        configureView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView() {
        titleLabel.addViewTo(self, topOffset: 5, leftOffset: HorizontalPadding, rightOffset: HorizontalPadding, bottomOffset: 5)
    }
    
}
