//
//  NewsListInteractor.swift
//  Buzz
//
//  Created by Caio Luna on 21/10/25.
//

import Foundation

protocol NewsListBusinessLogic {
	func loadNews(request: NewsListModel.FetchNews.Request)
}

protocol NewsListDataStore {
	var articles: [Article] { get set }
}

class NewsListInteractor: NewsListBusinessLogic, NewsListDataStore {
	private var worker: NewsAPIWorker
	var articles: [Article] = []
	var presenter: NewsListPresentationLogic?
	
	init(worker: NewsAPIWorker = NewsAPIWorker(networkingService: URLSessionNetworking())) {
		self.worker = worker
	}
	
	func loadNews(request: NewsListModel.FetchNews.Request) {
		worker.fetchNews { [weak self] result in
			
			guard let self else { return }
			
			DispatchQueue.main.async {
				switch result {
				case .success(let fetchedArticles):
					self.articles = fetchedArticles
					let response = NewsListModel.FetchNews.Response(articles: fetchedArticles)
					self.presenter?.presentFetchedNews(response: response)
					print(fetchedArticles)
				case .failure(let failure):
					print("There was an error when fetching articles: \(failure.localizedDescription)")
					self.presenter?.presentError(error: failure)
				}
			}
		}
	}
}
