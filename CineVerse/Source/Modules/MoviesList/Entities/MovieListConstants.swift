//
//  MovieListConstants.swift
//  CineVerse
//
//  Created by chandru-13685 on 29/03/24.
//

import Foundation

class MovieListParamConstants {
    static let popularRequestParams: [String: String] = [
        "include_adult": "false",
        "include_video": "false",
        "sort_by": "popularity.desc"
    ]
}

enum MovieType: String {
    case lastest = "Latest"
    case popular = "Popular"
}
