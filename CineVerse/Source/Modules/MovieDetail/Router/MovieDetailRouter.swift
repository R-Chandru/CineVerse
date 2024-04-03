//
//  MovieDetailRouter.swift
//  CineVerse
//
//  Created by chandru-13685 on 01/04/24.
//

import Foundation

class MovieDetailRouter: MovieDetailRouterProtocol {
    
    var view: MovieDetailVC?
    
    static func createModule(with movieDetail: MovieDetailAttributes) -> MovieDetailRouterProtocol {
        let router = MovieDetailRouter()
        var view: MovieDetailViewProtocol = MovieDetailVC()
        var presenter: MovieDetailPresenterProtocol = MovieDetailPresenter()
        var interactor: MovieDetailInteractorProtocol = MovieDetailInteractor(movieAttributes: movieDetail)
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.view = view as? MovieDetailVC
        
        return router
    }
    
}
