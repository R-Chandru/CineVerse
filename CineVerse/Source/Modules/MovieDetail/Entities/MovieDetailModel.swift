//
//  MovieDetailModel.swift
//  CineVerse
//
//  Created by chandru-13685 on 01/04/24.
//

import Foundation

struct MovieDetailAttributes {
    var movieItem: MovieListItem
    var moviePoster: MovieImageItem?
}


struct MovieDetailInfo {
    let title: String
    let value: String
    let keywords: [MovieKeywordModel]?
}


//MARK: Movie Detail Models

struct MovieDetailModel: Codable {
    let id: Int
    let name: String?
    let title: String?
    let runtime: Int?
    let budget: Int
    let revenue: Int
    let status: String?
    let overview: String?
    let posterPath: String
    let backdropPath: String?
    let voteAverage: Double
    let releaseDate: String?
    let firstAirDate: String?
    let originalLanguage: String?
    let genres: [MovieDetailGenre]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, title, budget, revenue, runtime, overview, genres, status
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
    }
}

struct MovieDetailGenre: Codable {
    let id: Int
    let name: String
}



//MARK: Movie Credit Models

struct MovieCreditResponse: Codable {
    let cast: [MovieCastModel]?
    let crew: [MovieCrewModel]?
}

struct MovieCastModel: Codable {
    let id: Int?
    let name: String
    let character: String?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, character
        case profilePath = "profile_path"
    }
}

struct MovieCrewModel: Codable {
    let id: Int?
    let name: String
    let job: String
}



//MARK: Movie Keywork Models

struct MovieKeyWordResponse: Codable {
    let keywords: [MovieKeywordModel]
}

struct MovieKeywordModel: Codable {
    let id: Int
    let name: String
}
