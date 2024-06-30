//
//  ListCategoriesCoordinator.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import UIKit

class ListCategoriesCoordinator: ListCategoriesBaseCoordinator {

    var parentCoordinator: MainBaseCoordinator?
    var rootViewController: UIViewController = UIViewController()
    
    func start() -> UIViewController {
        let categoriesVC = ListCategoriesScreen()
        categoriesVC.coordinator = self
        rootViewController = UINavigationController(rootViewController: categoriesVC)
        return rootViewController
    }
    
    func showJokeSortedByCategoryScreen() {
//        let jokeSortedByCategory = CategoriesViewController()
//        jokeSortedByCategory.coordinator = self
//        navigationRootViewController?.pushViewController(jokeSortedByCategory, animated: true)
    }
    
}
