//
//  ViewController.swift
//  Buzz
//
//  Created by Caio Luna on 14/10/25.
//

import UIKit

class NewsListViewController: UIViewController {
	
	private let interactor = NewsListInteractor()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		view.backgroundColor = .purple
		interactor.loadNews(request: NewsListModel.FetchNews.Request())
	}
}

