//
//  MovieOverviewView.swift
//  CineVerse
//
//  Created by chandru-13685 on 02/04/24.
//

import UIKit

class MovieOverviewCardView: UIView {
    
    private lazy var overviewTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = MovieDetailConstants.overview
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var overviewContent: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = MovieDetailConstants.userScore
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init() {
        super.init(frame: .zero)
        setUpViews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpViews() {
        backgroundColor = .systemBackground
        
        addOverviewTitle()
        addOverviewContent()
    }
    
    private func addOverviewTitle() {
        addSubview(overviewTitle)
        
        NSLayoutConstraint.activate([
            overviewTitle.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            overviewTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            overviewTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    
    private func addOverviewContent() {
        addSubview(overviewContent)
        
        NSLayoutConstraint.activate([
            overviewContent.topAnchor.constraint(equalTo: overviewTitle.bottomAnchor, constant: 20),
            overviewContent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            overviewContent.leadingAnchor.constraint(equalTo: leadingAnchor),
            overviewContent.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    
    //MARK: Date Update Methods
    
    func updateOverviewContent(with content: String?) {
        guard let content else {
            return
        }
        overviewContent.text = content
    }
    
}
