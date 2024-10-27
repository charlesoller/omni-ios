//
//  APIResource.swift
//  Omni
//
//  Created by Charles Oller on 10/26/24.
//

import Foundation

protocol APIResource {
    associatedtype ModelType: Codable
    var methodPath: String { get }
    var api: APIClient { get }
}

extension APIResource {
    var url: URL {
        let url = URL(string: "http://localhost:8080/api")!
            .appendingPathComponent(methodPath)

        return url
    }
}
