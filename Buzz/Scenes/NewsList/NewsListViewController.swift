//
//  ViewController.swift
//  Buzz
//
//  Created by Caio Luna on 14/10/25.
//

import UIKit

protocol NewsListDisplayLogic: AnyObject {
	func displayFetchedNews(viewModel: NewsListModel.FetchNews.ViewModel)
	func displayError(message: String)
}

class NewsListViewController: UIViewController {
	
	var interactor: NewsListBusinessLogic?
	var displayedArticles: [NewsListModel.FetchNews.ViewModel.DisplayedArticle] = []
	
	private lazy var newsListTableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		return tableView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(named: "AccentColor")
		setup()
		fetchNews()
		addSubviews()
		setupConstraints()
	}
	
	private func setup() {
		let viewController = self
		let interactor = NewsListInteractor()
		let presenter = NewsListPresenter()
		
		viewController.interactor = interactor
		interactor.presenter = presenter
		presenter.viewController = viewController
	}
	
	private func fetchNews() {
		interactor?.loadNews(request: NewsListModel.FetchNews.Request())
	}
	
	private func addSubviews() {
		view.addSubview(newsListTableView)
	}
	
	private func setupConstraints() {
		NSLayoutConstraint.activate([
			newsListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			newsListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			newsListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			newsListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
	}
}

extension NewsListViewController: NewsListDisplayLogic {
	func displayFetchedNews(viewModel: NewsListModel.FetchNews.ViewModel) {
		self.displayedArticles = viewModel.displayedArticles
		newsListTableView.reloadData()
	}
	
	func displayError(message: String) {
		let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .default))
		present(alert, animated: true)
	}
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return displayedArticles.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		var content = cell.defaultContentConfiguration()
		content.text = displayedArticles[indexPath.row].title
		cell.contentConfiguration = content
		return cell
	}
}
