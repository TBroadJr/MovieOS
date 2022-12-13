//
//  Manager.swift
//  MovieOS
//
//  Created by Tornelius Broadwater, Jr on 12/10/22.
//

import Foundation

class Manager: ObservableObject {
    
    @Published var movieItems = [MovieItem]()
    @Published var movies = [Movie]()

    
    // MARK: - Fetch Movies IDs
    func fetchMovieIDs() {
        NetworkEngine.request(endpoint: MovieEndpoint.fetchMovies) { (result: Result<Movies, Error>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async { [unowned self] in
                    self.movieItems = success.results
                }
            case .failure(let failure):
                print(failure)
                
            }
        }
    }
    
    // MARK: - Fetch Movie
    func fetchMovie(id: String) {
        
        guard doesNotContainMovie(id: id) else { return }
        
        NetworkEngine.request(endpoint: MovieEndpoint.fetchMovieInfo(movieID: id)) { [unowned self] (result: Result<Movie, Error>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async { [unowned self] in
                    self.movies.append(success)
                    print(movies.count)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func doesNotContainMovie(id: String) -> Bool {
        for movie in movies {
            if "\(movie.id)" == id {
                return false
            }
        }
        return true
    }
}
