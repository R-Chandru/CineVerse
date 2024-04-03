//
//  MovieDetailPresenter.swift
//  CineVerse
//
//  Created by chandru-13685 on 01/04/24.
//

import Foundation
import UIKit

class MovieDetailPresenter : MovieDetailPresenterProtocol {
    
    var view: MovieDetailViewProtocol?
    var router: MovieDetailRouterProtocol?
    var interactor: MovieDetailInteractorProtocol? {
        didSet {
            fetchMovieDetails()
        }
    }
    
    
    func fetchMovieDetails() {
        interactor?.fetchMovieDetails()
    }
    
    
    func updateMovieDetails(with movieDetails: MovieDetailModel) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.updateMovieDetails(with: movieDetails)
        }
    }
    
    
    func updateMovieCast(with movieCast: [MovieCastModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.updateMovieCast(with: movieCast)
        }
    }
    
    
    func updateMovieImage(with image: UIImage, type: MovieImageType) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.updateMovieImage(with: image, type: type)
        }
    }
    
    
    func updateMovieCastImages(with castImages: [MovieImageItem]) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.updateMovieCastImages(with: castImages)
        }
    }
    
    
    func updateMovieInfos(with movieInfo: [MovieDetailInfo]) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.updateMovieInfos(with: movieInfo)
        }
    }
}
