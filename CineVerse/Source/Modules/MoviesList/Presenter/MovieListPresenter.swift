//
//  MovieListPresenter.swift
//  CineVerse
//
//  Created by chandru-13685 on 29/03/24.
//

import Foundation

class MovieListPresenter : MovieListPresenterProtocol {
    
    var movieTypes: [MovieType] = [.lastest, .popular]
    
    var view: MovieListViewProtocol?
    var router: MovieListRouterProtocol?
    var interactor: MovieListInteractorProtocol? {
        didSet {
            fetchMovieList(for: movieTypes)
        }
    }
    
    func fetchMovieList(for types: [MovieType]) {
        interactor?.fetchMovieList(for: types)
    }
    
    func showDetailView(for movieDetail: MovieDetailAttributes) {
        router?.showDetailView(for: movieDetail)
    }
    
    func updateMovieList(with movieList: [MovieType : [MovieListItem]], type: MovieType) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.updateMovieList(with: movieList, type: type)
        }
    }
    
    func updateMovieListPoster(with imagesList: [MovieType : [MovieImageItem]], type: MovieType) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.updateMovieListPoster(with: imagesList, type: type)
        }
    }
    
    func showErrorView() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.showErrorView()
        }
    }
    
}
