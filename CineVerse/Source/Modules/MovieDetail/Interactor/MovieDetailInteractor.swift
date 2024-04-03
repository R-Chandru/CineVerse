//
//  MovieDetailInteractor.swift
//  CineVerse
//
//  Created by chandru-13685 on 01/04/24.
//

import Foundation
import UIKit
import CineVerseNetworkFramework


class MovieDetailInteractor: MovieDetailInteractorProtocol {
    
    let movieAttributes: MovieDetailAttributes
    let networkService: CineVerseNetworkService
    
    var movieDetails: MovieDetailModel?
    var presenter: MovieDetailPresenterProtocol?
    
    
    init(movieAttributes: MovieDetailAttributes) {
        self.movieAttributes = movieAttributes
        self.networkService = CineVerseNetworkService()
    }
    
    
    func fetchMovieDetails() {
        let movieID = String(movieAttributes.movieItem.id)
        downloadMovieDetails(with: movieID)
        downloadMovieCredits(with: movieID)
        downloalMovieKeywords(with: movieID)
    }
    
    
    private func downloadMovieDetails(with movieID: String) {
        networkService.request(with: .getMovieDetail, requestID: movieID, params: [:]) { (result: Result<NetworkResponse<MovieDetailModel>, Error>) in
            switch result {
            case .success(let response):
                self.handleMovieDetailSuccess(with: response.data)
            case .failure(let error):
                self.handleMovieDetailFailure(with: error)
            }
        }
    }
    
    
    private func downloadMovieCredits(with movieID: String) {
        networkService.request(with: .getMovieDetailCredits, requestID: movieID, params: [:]) { (result: Result<NetworkResponse<MovieCreditResponse>, Error>) in
            switch result {
            case .success(let response):
                self.handleMovieCreditsSuccess(with: response.data)
            case .failure(let error):
                self.handleMovieDetailFailure(with: error)
            }
        }
    }
    
    
    private func downloadCastImages(with movieCasts: [MovieCastModel]) {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 10
        
        var downloadedImages = [MovieImageItem]()
        let dispatchGroup = DispatchGroup()
        
        for movieCast in movieCasts {
            guard movieCast.profilePath != nil else {
                continue
            }
            
            dispatchGroup.enter()
            downloadImage(for: movieCast) { result in
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
            self.handleCastImagesSuccess(with: downloadedImages)
        }
    }

    private func downloadImage(for movieCast: MovieCastModel, completion: @escaping (Result<MovieImageItem, Error>) -> Void) {
        guard let profilePath = movieCast.profilePath else {
            return
        }
        
        networkService.requestImage(with: .getMovieImage, path: profilePath) { result in
            switch result {
            case .success(let response):
                let posterItem = MovieImageItem(id: movieCast.id ?? 0, image: response.data)
                completion(.success(posterItem))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    private func downloadMovieImage(for path: String, imageType: MovieImageType) {
        networkService.requestImage(with: .getMovieImage, path: path) { [weak self] result in
            guard let self else {
                return
            }
            
            switch result {
            case .success(let response):
                self.handleMovieImageSuccess(with: response.data, type: imageType)
                break
            case .failure(let error):
                print("Image Download Failed with Error: ", error)
            }
        }
    }
    
    
    private func downloalMovieKeywords(with movieID: String) {
        networkService.request(with: .getMovieDetailKeywords, requestID: movieID, params: [:]) { (result: Result<NetworkResponse<MovieKeyWordResponse>, Error>) in
            switch result {
            case .success(let response):
                self.handleKeywordSuccess(with: response.data)
            case .failure(let error):
                print("Movie Keyword Download Failed with Error: ", error)
            }
        }
    }
    
    
    private func getMovieInfo(with keywords: [MovieKeywordModel]) -> [MovieDetailInfo] {
        var movieInfo = [MovieDetailInfo]()
        
        movieInfo.append ( MovieDetailInfo(
            title: MovieInfoConstants.status,
            value: movieDetails?.status ?? "-",
            keywords: nil
        ))
        
        movieInfo.append ( MovieDetailInfo(
            title: MovieInfoConstants.originalLanguage,
            value: CommonUtils.getLanguageName(fromCode: movieDetails?.originalLanguage) ?? "-",
            keywords: nil
        ))
        
        let budget: String
        if let movieBudget = movieDetails?.budget, movieBudget != 0 {
            budget = CommonUtils.formatCurrency(amount: movieBudget) ?? "-"
        } else {
            budget = "-"
        }
        movieInfo.append ( MovieDetailInfo(
            title: MovieInfoConstants.budget,
            value: budget,
            keywords: nil
        ))
        
        let revenue: String
        if let movieRevenue = movieDetails?.revenue, movieRevenue != 0 {
            revenue = CommonUtils.formatCurrency(amount: movieRevenue) ?? "-"
        } else {
            revenue = "-"
        }
        movieInfo.append ( MovieDetailInfo(
            title: MovieInfoConstants.revenue,
            value: revenue,
            keywords: nil
        ))
        
        movieInfo.append( MovieDetailInfo(
            title: MovieInfoConstants.keywords,
            value: "",
            keywords: keywords
        ))
        
        return movieInfo
    }
    
    
    
    //MARK: Success / Failure Handlers
    
    private func handleMovieDetailSuccess(with movieDetails: MovieDetailModel) {
        self.movieDetails = movieDetails
        presenter?.updateMovieDetails(with: movieDetails)
        
        if let image = ImageCache.shared.getImage(for: String(movieDetails.id)) {
            presenter?.updateMovieImage(with: image, type: .poster)
        } else {
            downloadMovieImage(for: movieDetails.posterPath, imageType: .poster)
        }
        downloadMovieImage(for: movieDetails.backdropPath, imageType: .background)
    }
    
    
    private func handleMovieCreditsSuccess(with creditDetials: MovieCreditResponse) {
        if let cast = creditDetials.cast {
            presenter?.updateMovieCast(with: cast)
            downloadCastImages(with: cast)
        }
    }
    
    
    private func handleKeywordSuccess(with response: MovieKeyWordResponse) {
        let movieInfo = getMovieInfo(with: response.keywords)
        presenter?.updateMovieInfos(with: movieInfo)
    }
    
    
    private func handleCastImagesSuccess(with images: [MovieImageItem]) {
        presenter?.updateMovieCastImages(with: images)
    }
    
    
    private func handleMovieImageSuccess(with image: UIImage?, type: MovieImageType) {
        guard let image else {
            return
        }
        presenter?.updateMovieImage(with: image, type: type)
    }
    
    
    private func handleMovieDetailFailure(with error: Error) {
        print("Movie List Failed with Error: \(error)")
    }
    
}
