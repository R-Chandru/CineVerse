//
//  MovieDetailProtocols.swift
//  CineVerse
//
//  Created by chandru-13685 on 01/04/24.
//

import Foundation
import UIKit

protocol MovieDetailRouterProtocol {
    var view: MovieDetailVC? { get }
    
    static func createModule(with movieDetail: MovieDetailAttributes) -> MovieDetailRouterProtocol
}


protocol MovieDetailViewProtocol {
    var presenter: MovieDetailPresenterProtocol? { get set }
    
    func updateMovieDetails(with movieDetails: MovieDetailModel)
    func updateMovieCast(with movieCast: [MovieCastModel])
    func updateMovieCastImages(with castImages: [MovieImageItem])
    func updateMovieImage(with image: UIImage, type: MovieImageType)
    func updateMovieInfos(with movieInfo: [MovieDetailInfo])
}


protocol MovieDetailPresenterProtocol {
    var view: MovieDetailViewProtocol? { get set }
    var router: MovieDetailRouterProtocol? { get set }
    var interactor: MovieDetailInteractorProtocol? { get set }
    
    func updateMovieDetails(with movieDetails: MovieDetailModel)
    func updateMovieCast(with movieCast: [MovieCastModel])
    func updateMovieCastImages(with castImages: [MovieImageItem])
    func updateMovieImage(with image: UIImage, type: MovieImageType)
    func updateMovieInfos(with movieInfo: [MovieDetailInfo])
}


protocol MovieDetailInteractorProtocol {
    var presenter: MovieDetailPresenterProtocol? { get set }
    
    func fetchMovieDetails()
}
