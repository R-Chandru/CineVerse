//
//  MovieDetailConstants.swift
//  CineVerse
//
//  Created by chandru-13685 on 01/04/24.
//

import Foundation

enum MovieImageType {
    case poster
    case background
}


enum MovieDetailSegment: Int {
    case cast = 0
    case info = 1
    
    static let allValues = [cast, info]
}



struct MovieDetailConstants {
    static let title = "CineVerse"
    static let back = "Back"
    static let userScore = "User Score"
    static let overview = "Overview"
    static let topBilledCase = "Top Billed Cast"
}


struct MovieInfoConstants {
    static let status = "Status"
    static let originalLanguage = "Original Language"
    static let budget = "Budget"
    static let revenue = "Revenue"
    static let keywords = "Keywords"
}


struct MovieDetailErrorConstants {
    static let unknownError = "The resource you requested could not be found"
}
