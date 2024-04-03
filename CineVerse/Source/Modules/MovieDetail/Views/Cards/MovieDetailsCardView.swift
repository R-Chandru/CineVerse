//
//  MovieDetailsCardView.swift
//  CineVerse
//
//  Created by chandru-13685 on 02/04/24.
//

import UIKit

class MovieDetailsCardView: UIView {
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: HorizontalPadding)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: HorizontalPadding)
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
    
    
    func setUpViews() {
        backgroundColor = .secondarySystemBackground
        adddurationLabel()
        addGenreLabel()
    }
    
    
    private func adddurationLabel() {
        addSubview(durationLabel)
        
        NSLayoutConstraint.activate([
            durationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            durationLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            durationLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    
    private func addGenreLabel() {
        addSubview(genreLabel)
        
        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 7),
            genreLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            genreLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            genreLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    
    // MARK: Date Update Methods
    
    func updateMovie(with movieDetail: MovieDetailModel) {
        if let date = movieDetail.releaseDate, let runTime = movieDetail.runtime {
            let runTimeInHours = DateUtil.minutesToTimeString(runTime)
            durationLabel.text = "\(date)  •  \(runTimeInHours)"
        }
        
        if let movieGenres = movieDetail.genres, !movieGenres.isEmpty {
            let genres = movieGenres.map { $0.name }
            let genreString = genres.joined(separator: ", ")
            genreLabel.text = genreString
        }
    }
}
