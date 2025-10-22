//
//  URLSessionNetworking.swift
//  Buzz
//
//  Created by Caio Luna on 21/10/25.
//

import Foundation

protocol NetworkingService {
	func request<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
}

enum NetworkingError: Error {
	case invalidUrl
	case invalidResponse
	case invalidData
	case decodingError
}

class URLSessionNetworking: NetworkingService {
	func request<T>(url: URL, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
		
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if let error {
				completion(.failure(error))
				return
			}
			
			guard let data else {
				completion(.failure(NetworkingError.invalidData))
				return
	 		}
			
			do {
				let decoder = JSONDecoder()
				decoder.dateDecodingStrategy = .iso8601
				let decodedData = try decoder.decode(T.self, from: data)
				completion(.success(decodedData))
			} catch {
				completion(.failure(NetworkingError.decodingError))
				return
			}
		}
		
		task.resume()
	}
}
