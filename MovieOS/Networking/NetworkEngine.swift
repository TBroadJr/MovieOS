//
//  NetworkEngine.swift
//  MovieOS
//
//  Created by Tornelius Broadwater, Jr on 12/11/22.
//

import Foundation

class NetworkEngine {
    
    class func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> () ) {
        
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.host
        components.path = endpoint.path
        components.queryItems = endpoint.queryItems
        
        guard let url = components.url else {
            Log.error("URL could not be created from components")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
                
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            do {
                let responseObjects = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseObjects))
            } catch {
                completion(.failure(error))
            }
            
        }
        dataTask.resume()
    }
}
