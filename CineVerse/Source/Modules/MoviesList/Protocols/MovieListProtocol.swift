//
//  MovieListProtocol.swift
//  CineVerse
//
//  Created by chandru-13685 on 29/03/24.
//

import Foundation
import UIKit

protocol MovieListRouterProtocol {
    var view: MovieListVC? { get }
    
    static func createModule() -> MovieListRouterProtocol
    func showDetailView(for movieDetail: MovieDetailAttributes)
}

protocol MovieListViewProtocol {
    var presenter: MovieListPresenterProtocol? { get set }
    
    func updateMovieList(with movieList: [MovieType : [MovieListItem]], type: MovieType)
    func updateMovieListPoster(with imagesList: [MovieType : [MovieImageItem]], type: MovieType)
    func showErrorView()
}

protocol MovieListPresenterProtocol {
    var movieTypes: [MovieType] { get }
    var view: MovieListViewProtocol? { get set }
    var router: MovieListRouterProtocol? { get set }
    var interactor: MovieListInteractorProtocol? { get set }
    
    func fetchMovieList(for types: [MovieType])
    func showDetailView(for movie: MovieDetailAttributes)
    func updateMovieList(with movieList: [MovieType : [MovieListItem]], type: MovieType)
    func updateMovieListPoster(with imagesList: [MovieType : [MovieImageItem]], type: MovieType)
    func showErrorView()
}

protocol MovieListInteractorProtocol {
    var presenter: MovieListPresenterProtocol? { get set }
    
    func fetchMovieList(for types: [MovieType])
}

protocol MovieListViewDelegate {
    func didSelectMovie(with movieItem: MovieDetailAttributes)
}
