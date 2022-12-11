//
//  MovieEndpoint.swift
//  MovieOS
//
//  Created by Tornelius Broadwater, Jr on 12/10/22.
//

import Foundation
enum MovieEndpoint: Endpoint {
    
case fetchMovies
case fetchMovieInfo(movieID: String)
    
    var scheme: String {
        switch self {
        case .fetchMovies:
            return "https"
        
        case .fetchMovieInfo:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .fetchMovies:
            return "api.themoviedb.org"
            
        case .fetchMovieInfo:
            return "api.themoviedb.org"
        }
    }
    
    var path: String {
        switch self {
        case .fetchMovies:
            return "/3/discover/movie"
            
        case .fetchMovieInfo(let movieID):
            return "/3/movie/\(movieID)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        let apiKey = "5304337eba07099775bfd6e08dced4f9"
        
        switch self {
        case .fetchMovies:
            return [URLQueryItem(name: "api_key", value: apiKey)]
            
        case .fetchMovieInfo:
            return [URLQueryItem(name: "api_key", value: apiKey)]
                  
        }
    }
    
    var method: String {
        switch self {
        case .fetchMovies:
            return "GET"
            
        case .fetchMovieInfo:
            return "GET"
        }
    }
    
    
}
