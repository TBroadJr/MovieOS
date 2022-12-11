//
//  Movie.swift
//  MovieOS
//
//  Created by Tornelius Broadwater, Jr on 12/11/22.
//

import Foundation

struct Movie: Codable {
    let title: String
    let budget: Double
    let genres: [Genre]
    let homepage: URL
    let overview: String
    let productionCompanies: [Company]
    let releaseDate: String
    let revenue: Double
    let runtime: Double
    let tagline: String
    let rating: Double
    let backdropPath: String
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case title, budget, genres, homepage, overview, revenue, runtime, tagline
        case productionCompanies = "production_companies"
        case releaseDate = "release_date"
        case rating = "vote_average"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
    }
}

struct Genre: Codable {
    let name: String
}

struct Company: Codable {
    let name: String
    let logoPath: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case logoPath = "logo_path"
    }
}
