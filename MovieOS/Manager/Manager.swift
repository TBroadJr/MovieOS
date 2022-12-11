//
//  Manager.swift
//  MovieOS
//
//  Created by Tornelius Broadwater, Jr on 12/10/22.
//

import Foundation
import CoreData

class Manager: ObservableObject {
    let container = NSPersistentContainer(name: "MovieModel")
    
    @Published var movieItems = [MovieItem]()
    @Published var movies = [Movie]()
    
    init() {
        container.loadPersistentStores { description, error in
            if error != nil {
                Log.error("Cannot load persistent stores")
            }
        }
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
    // MARK: - Fetch Movies IDs
    func fetchMovieIDs() {
        NetworkEngine.request(endpoint: MovieEndpoint.fetchMovies) { (result: Result<Movies, Error>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async { [unowned self] in
                    self.movieItems.append(contentsOf: success.results)
                    print(self.movieItems)
                }
            case .failure(let failure):
                print(failure)
                
            }
        }
    }
    
    // MARK: - Fetch Movie
    func fetchMovie(id: String) {
        NetworkEngine.request(endpoint: MovieEndpoint.fetchMovieInfo(movieID: id)) { (result: Result<Movie, Error>) in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}
