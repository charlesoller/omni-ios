//
//  NetworkManager.swift
//  Omni
//
//  Created by Charles Oller on 10/27/24.
//

import Foundation

protocol APIClient {
    func get<T: Decodable>(url: URL) async throws -> T
    func post<T: Decodable, U: Encodable>(url: URL, body: U) async throws -> T
    func put<T: Decodable, U: Encodable>(url: URL, body: U) async throws -> T
    func delete<T: Decodable>(url: URL) async throws -> T
}


class NetworkManager: APIClient {
    private let urlCache: URLCache

    init(urlCache: URLCache = .shared) {
        self.urlCache = urlCache
    }

    func get<T: Decodable>(url: URL) async throws -> T {
        if let cachedResponse = urlCache.cachedResponse(for: URLRequest(url: url)) {
            let decodedData = try JSONDecoder().decode(T.self, from: cachedResponse.data)
            return decodedData
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            let cachedResponse = CachedURLResponse(response: response, data: data)
            urlCache.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
        }

        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }

    func post<T: Decodable, U: Encodable>(url: URL, body: U) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }

    func put<T: Decodable, U: Encodable>(url: URL, body: U) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }

    func delete<T: Decodable>(url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}


