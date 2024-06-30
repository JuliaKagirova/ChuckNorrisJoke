//
//  MainCoordinator.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import UIKit

enum AppFlow {
    case loadedJoke
    case sortedJoke
    case listCategories
}

class MainCoordinator: MainBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var loadedJokeCoordinator: LoadedJokeBaseCoordinator = LoadedJokeCoordinator()
    
    lazy var sortedJokeCoordinator: SortedJokeBaseCoordinator = SortedJokeCoordinator()
    
    lazy var listCategoriesCoordinator: ListCategoriesBaseCoordinator = ListCategoriesCoordinator()
    
    lazy var rootViewController: UIViewController = UITabBarController()
    
    func start() -> UIViewController {
        let loadedJokeViewController = loadedJokeCoordinator.start()
        loadedJokeViewController.view.backgroundColor = .white
        loadedJokeCoordinator.parentCoordinator = self
        loadedJokeViewController.tabBarItem = UITabBarItem(
            title: "Loaded",
            image: UIImage(systemName: "square.and.arrow.down"),
            tag: 0
        )
        
        let sortedtJokeViewController = sortedJokeCoordinator.start()
        sortedtJokeViewController.view.backgroundColor = .white
        sortedJokeCoordinator.parentCoordinator = self
        sortedtJokeViewController.tabBarItem = UITabBarItem(
            title: "Sorted",
            image: UIImage(systemName: "wand.and.stars.inverse"),
            tag: 1
        )
        
        let listCategoriesViewController = listCategoriesCoordinator.start()
        listCategoriesViewController.view.backgroundColor = .white
        listCategoriesCoordinator.parentCoordinator = self
        listCategoriesViewController.tabBarItem = UITabBarItem(
            title: "Categories",
            image: UIImage(systemName: "list.star"),
            tag: 2
        )
        
        (rootViewController as? UITabBarController)?.viewControllers = [
            loadedJokeViewController,
            sortedtJokeViewController,
            listCategoriesViewController
        ]
        return rootViewController
    }
    
    func moveTo(flow: AppFlow) {
        switch flow {
        case .loadedJoke:
            (rootViewController as? UITabBarController)?.selectedIndex = 0
        case .sortedJoke:
            (rootViewController as? UITabBarController)?.selectedIndex = 1
        case .listCategories:
            (rootViewController as? UITabBarController)?.selectedIndex = 2
        }
    }
    
    func resetToRoot() -> Self {
        loadedJokeCoordinator.resetToRoot()
        moveTo(flow: .loadedJoke)
        return self
    }
}
