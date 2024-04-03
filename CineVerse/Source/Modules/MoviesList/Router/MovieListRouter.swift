//
//  MovieListRouter.swift
//  CineVerse
//
//  Created by chandru-13685 on 29/03/24.
//

import Foundation
import UIKit

typealias MovieList = MovieListViewProtocol & UIViewController

class MovieListRouter: MovieListRouterProtocol {
    
    var view: MovieListVC?
    
    static func createModule() -> MovieListRouterProtocol {
        let router = MovieListRouter()
        var view: MovieListViewProtocol = MovieListVC()
        var presenter: MovieListPresenterProtocol = MovieListPresenter()
        var interactor: MovieListInteractorProtocol = MovieListInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.view = view as? MovieListVC
        
        return router
    }
    
    func showDetailView(for movieDetail: MovieDetailAttributes) {
        let movieDetail = MovieDetailRouter.createModule(with: movieDetail)
        guard let movieDetailView  = movieDetail.view else {
            return
        }
        
        self.view?.navigationController?.pushViewController(movieDetailView, animated: true)
    }
    
}
