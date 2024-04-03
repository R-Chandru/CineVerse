//
//  MovieListModel.swift
//  CineVerse
//
//  Created by chandru-13685 on 29/03/24.
//

import Foundation
import UIKit

struct MovieListResponse: Codable {
    let results: [MovieListItem]
}

struct MovieListItem: Codable {
    let id: Int
    let name: String?
    let title: String?
    let voteAverage: Double
    let firstAirDate: String?
    let releaseDate: String?
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, title
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case posterPath = "poster_path"
    }
}

struct MovieImageItem {
    let id: Int
    let image: UIImage?
}
