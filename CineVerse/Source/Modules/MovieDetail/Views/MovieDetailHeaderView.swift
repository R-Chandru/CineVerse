//
//  MovieDetailHeaderView.swift
//  CineVerse
//
//  Created by chandru-13685 on 01/04/24.
//

import UIKit

class MovieDetailHeaderView: UIView {
    
    private let padding: CGFloat = HorizontalPadding
    
    private lazy var containerView = UIView()
    private lazy var ratingHolderView = UIView()
    private lazy var movieDetailCard = MovieDetailsCardView()
    private lazy var overviewCard = MovieOverviewCardView()
    
    private lazy var ratingView: PercentageCircleView = {
        let ratingView = PercentageCircleView()
        ratingView.fontSize = 13
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        return ratingView
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private lazy var userScoreLabel: UILabel = {
        let label = UILabel()
        label.text = MovieDetailConstants.userScore
        label.font = UIFont.systemFont(ofSize: HorizontalPadding, weight: .semibold)
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
        
        addContainerView()
        addBackgroundImageView()
        addPosterImageView()
        addtitleLabel()
        
        configureRatingView()
        addMovieDetailCard()
        addOverviewCard()
    }
    
    
    private func addContainerView() {
        containerView.addViewTo(self)
    }
    
    
    private func addBackgroundImageView() {
        containerView.addSubview(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            backgroundImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 50),
            backgroundImageView.heightAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6)
        ])
    }
    
    
    private func addPosterImageView() {
        containerView.addSubview(posterImageView)
        
        NSLayoutConstraint.activate([
            posterImageView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            posterImageView.heightAnchor.constraint(equalTo: backgroundImageView.heightAnchor, multiplier: 0.6),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.7)
        ])
    }
    
    
    private func addtitleLabel() {
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
        ])
    }
    
    
    private func configureRatingView() {
        addRatingHolderView()
        addRatingView()
        addUserScoreLabel()
    }
    
    
    private func addRatingHolderView() {
        containerView.addSubview(ratingHolderView)
        ratingHolderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ratingHolderView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            ratingHolderView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            ratingHolderView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    private func addRatingView() {
        ratingHolderView.addSubview(ratingView)
        
        NSLayoutConstraint.activate([
            ratingView.widthAnchor.constraint(equalToConstant: 60),
            ratingView.heightAnchor.constraint(equalToConstant: 60),
            ratingView.leadingAnchor.constraint(equalTo: ratingHolderView.leadingAnchor),
            ratingView.centerYAnchor.constraint(equalTo: ratingHolderView.centerYAnchor)
        ])
    }
    
    
    private func addUserScoreLabel() {
        ratingHolderView.addSubview(userScoreLabel)
        
        NSLayoutConstraint.activate([
            userScoreLabel.leadingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: 10),
            userScoreLabel.trailingAnchor.constraint(equalTo: ratingHolderView.trailingAnchor),
            userScoreLabel.centerYAnchor.constraint(equalTo: ratingHolderView.centerYAnchor),
        ])
    }
    
    
    private func addMovieDetailCard() {
        containerView.addSubview(movieDetailCard)
        movieDetailCard.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieDetailCard.topAnchor.constraint(equalTo: ratingHolderView.bottomAnchor, constant: 10),
            movieDetailCard.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            movieDetailCard.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    
    private func addOverviewCard() {
        containerView.addSubview(overviewCard)
        overviewCard.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            overviewCard.topAnchor.constraint(equalTo: movieDetailCard.bottomAnchor),
            overviewCard.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            overviewCard.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            overviewCard.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
        ])
    }
    
    
    //MARK: Data Updaters
    
    func updateMovieDetails(with movieDetails: MovieDetailModel) {
        let movieTitle = CommonUtils.getNonOptionalString(movieDetails.title, movieDetails.name)
        let movieReleaseDate = CommonUtils.getNonOptionalString(movieDetails.releaseDate, movieDetails.firstAirDate)
        let movieReleaseYear = DateUtil.getYearFromDate(dateString: movieReleaseDate)
        
        titleLabel.attributedText = CommonUtils.getTitleFormatString(with: movieTitle, additionalText: "(\(movieReleaseYear))")
        ratingView.percentage = CommonUtils.decimalToPercentage(movieDetails.voteAverage)
        
        movieDetailCard.updateMovie(with: movieDetails)
        overviewCard.updateOverviewContent(with: movieDetails.overview)
    }
    
    
    func updatePosterImage(with image: UIImage) {
        posterImageView.image = image
    }
    
    
    func updateBackgroundImage(with image: UIImage) {
        backgroundImageView.image = image
        UIUtils.fade(imageView: backgroundImageView, side: .left)
    }
    
}
