//
//  Endpoint.swift
//  MovieOS
//
//  Created by Tornelius Broadwater, Jr on 12/10/22.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var method: String { get }
}
