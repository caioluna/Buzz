//
//  NewsListRouter.swift
//  Buzz
//
//  Created by Caio Luna on 14/10/25.
//

import UIKit

class NewsListRouter {
	static func createInitialViewController() -> UIViewController {
		
		let newsListViewController = NewsListViewController()
		let navigationController = UINavigationController(rootViewController: newsListViewController)
		
		return navigationController
	}
}
