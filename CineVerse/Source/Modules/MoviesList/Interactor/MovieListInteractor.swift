//
//  MovieListInteractor.swift
//  CineVerse
//
//  Created by chandru-13685 on 29/03/24.
//

import Foundation
import UIKit
import CineVerseNetworkFramework

class MovieListInteractor: MovieListInteractorProtocol {
    
    var presenter: MovieListPresenterProtocol?
    
    private let networkService: CineVerseNetworkServiceProtocol
    private var movieListData: [MovieType : [MovieListItem]] = [:]
    private var movieListPosterData: [MovieType : [MovieImageItem]] = [:]
    
    
    init() {
        self.networkService = CineVerseNetworkService()
    }
    
    func fetchMovieList(for types: [MovieType]) {
        for type in types {
            let api: CineVerseAPI
            var params: [String : String] = [:]
            
            switch type {
            case .lastest:
                api = .getLatestMovieList
            case .popular:
                api = .getPopularMovieList
                params = MovieListParamConstants.popularRequestParams
            }
            
            downloadMovieList(for: api, params: params, type: type)
        }
    }
    
    
    private func downloadMovieList(for api: CineVerseAPI, params: [String: String], type: MovieType) {
        networkService.request(with: api, requestID: nil, params: params) { [weak self] (result: Result<NetworkResponse<MovieListResponse>, Error>) in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let response):
                self.handleMovieListSuccess(with: response.data, for: type)
            case .failure(let error):
                self.handleMovieListFailure(with: error)
            }
        }
    }
    
    
    private func downloadMoviePosters(with movieListItems: [MovieListItem], for type: MovieType) {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 10
        
        var downloadedImages = [MovieImageItem]()
        let dispatchGroup = DispatchGroup()
        
        for movieListItem in movieListItems {
            dispatchGroup.enter()
            downloadImage(for: movieListItem) { result in
                switch result {
                case .success(let posterItem):
                    downloadedImages.append(posterItem)
                case .failure(let error):
                    print("Image Download Failed with Error: ", error)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
            self.handleMovieImagesCompletion(downloadedImages, for: type)
        }
    }

    private func downloadImage(for movieListItem: MovieListItem, completion: @escaping (Result<MovieImageItem, Error>) -> Void) {
        networkService.requestImage(with: .getMovieImage, path: movieListItem.posterPath) { result in
            switch result {
            case .success(let response):
                let image = response.data
                if let image {
                    ImageCache.shared.setImage(image, for: String(movieListItem.id))
                }
                let posterItem = MovieImageItem(id: movieListItem.id, image: image)
                completion(.success(posterItem))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    //MARK: Success / Error Handlers
    
    private func handleMovieListSuccess(with response: MovieListResponse, for type: MovieType) {
        let movieListItems = response.results
        movieListData[type] = movieListItems
        presenter?.updateMovieList(with: movieListData, type: type)
        downloadMoviePosters(with: movieListItems, for: type)
    }
    
    
    private func handleMovieListFailure(with error: Error) {
        print("Movie List Failed with Error: \(error)")
    }
    
    
    private func handleMovieImagesCompletion(_ downloadedImages: [MovieImageItem], for type: MovieType) {
        movieListPosterData[type] = downloadedImages
        presenter?.updateMovieListPoster(with: movieListPosterData, type: type)
    }
    
}
