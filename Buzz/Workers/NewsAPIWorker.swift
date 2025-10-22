//
//  NewsAPIWorker.swift
//  Buzz
//
//  Created by Caio Luna on 21/10/25.
//

import Foundation

enum NewsAPI {
	static let baseURL = "https://my-json-server.typicode.com/alura-cursos/news-api/"
	static let articles = "articles"
}

class NewsAPIWorker {
	private let networkingService: NetworkingService
	
	init(networkingService: NetworkingService) {
		self.networkingService = networkingService
	}
	
	func fetchNews(completion: @escaping (Result<[Article], Error>) -> Void) {
		guard let url = URL(string: NewsAPI.baseURL + NewsAPI.articles) else {
			completion(.failure(NetworkingError.invalidUrl))
			return
		}
		
		networkingService.request(url: url) { (result: Result<[Article], Error>) in
			switch result {
			case .success(let response):
				completion(.success(response))
			case .failure(let failure):
				completion(.failure(failure))
			}
		}
	}
}
