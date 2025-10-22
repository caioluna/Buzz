//
//  NewsListInteractor.swift
//  Buzz
//
//  Created by Caio Luna on 21/10/25.
//

import Foundation

class NewsListInteractor {
	private var worker: NewsAPIWorker
	private var articles: [Article] = []
	
	init(worker: NewsAPIWorker = NewsAPIWorker(networkingService: URLSessionNetworking())) {
		self.worker = worker
	}
	
	func loadNews() {
		worker.fetchNews { [weak self] result in
			guard let self else { return }
			DispatchQueue.main.async {
				switch result {
				case .success(let fetchedArticles):
					self.articles = fetchedArticles
					print(fetchedArticles)
				case .failure(let failure):
					print("There was an error when fetching articles: \(failure)")
				}
			}
		}
	}
}
