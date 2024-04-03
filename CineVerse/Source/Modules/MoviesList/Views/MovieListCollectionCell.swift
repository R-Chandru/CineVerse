//
//  MovieCollectionCell.swift
//  CineVerse
//
//  Created by chandru-13685 on 29/03/24.
//

import UIKit
import Foundation

class MovieCollectionCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionCell"
    
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "movie_list_placeholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var percentageView: PercentageCircleView = {
        let percentageView = PercentageCircleView()
        percentageView.translatesAutoresizingMaskIntoConstraints = false
        return percentageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: HorizontalPadding, weight: .semibold)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .light)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addImageView()
        addPercentageView()
        addTitleLabel()
        addDateLabel()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addImageView() {
        addSubview(movieImageView)
        
        NSLayoutConstraint.activate([
            movieImageView.heightAnchor.constraint(equalToConstant: 250),
            movieImageView.widthAnchor.constraint(equalToConstant: 175),
            movieImageView.topAnchor.constraint(equalTo: topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    
    private func addPercentageView() {
        addSubview(percentageView)
        
        NSLayoutConstraint.activate([
            percentageView.heightAnchor.constraint(equalToConstant: 50),
            percentageView.widthAnchor.constraint(equalToConstant: 50),
            percentageView.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor, constant: 10),
            percentageView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -25)
        ])
    }
    
    
    private func addTitleLabel() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: percentageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    
    private func addDateLabel() {
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    
    func setMovieDetails(with movie: MovieListItem) {
        titleLabel.text = CommonUtils.getNonOptionalString(movie.title, movie.name)
        percentageView.percentage = CommonUtils.decimalToPercentage(movie.voteAverage)
        let date = CommonUtils.getNonOptionalString(movie.releaseDate, movie.firstAirDate)
        dateLabel.text = DateUtil.convertDateString(date)
    }
    
    
    func setMoviePoster(with image: UIImage?) {
        movieImageView.image = image
    }
    
}
