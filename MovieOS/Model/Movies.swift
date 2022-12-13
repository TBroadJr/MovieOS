//
//  Movies.swift
//  MovieOS
//
//  Created by Tornelius Broadwater, Jr on 12/11/22.
//

import Foundation

struct Movies: Codable {
    let results: [MovieItem]
}

struct MovieItem: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let backdropPath: String
    let posterPath: String
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case rating = "vote_average"
    }
}


