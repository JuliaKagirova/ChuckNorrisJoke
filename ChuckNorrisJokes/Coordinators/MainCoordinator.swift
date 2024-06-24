//
//  MainCoordinator.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import UIKit

enum AppFlow {
    case loadJoke
    case listJoke
    case sortedJoke
}

class MainCoordinator: MainBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var loadJokeCoordinator: LoadJokeBaseCoordinator = LoadJokeCoordinator()
    
    lazy var listJokeCoordinator: ListJokeBaseCoordinator = ListJokeCoordinator()
    
    lazy var sortedJokeCoordinator: SortedJokeBaseCoordinator = SortedJokeCoordinator()
    
    lazy var rootViewController: UIViewController = UITabBarController()
    
    func start() -> UIViewController {
        let loadJokeViewController = loadJokeCoordinator.start()
        loadJokeViewController.view.backgroundColor = .white
        loadJokeCoordinator.parentCoordinator = self
        loadJokeViewController.tabBarItem = UITabBarItem(
            title: "Load",
            image: UIImage(systemName: "square.and.arrow.down"),
            tag: 0
        )
        
        let listJokeViewController = listJokeCoordinator.start()
        listJokeViewController.view.backgroundColor = .white
        listJokeCoordinator.parentCoordinator = self
        listJokeViewController.tabBarItem = UITabBarItem(
            title: "List",
            image: UIImage(systemName: "list.star"),
            tag: 1
        )
        
        let sortedJokeViewController = sortedJokeCoordinator.start()
        sortedJokeViewController.view.backgroundColor = .white
        sortedJokeCoordinator.parentCoordinator = self
        sortedJokeViewController.tabBarItem = UITabBarItem(
            title: "Sorted",
            image: UIImage(systemName: "wand.and.stars.inverse"),
            tag: 2
        )
        
        (rootViewController as? UITabBarController)?.viewControllers = [
            loadJokeViewController,
            listJokeViewController,
            sortedJokeViewController
        ]
        return rootViewController
    }
    
    func moveTo(flow: AppFlow) {
        switch flow {
        case .loadJoke:
            (rootViewController as? UITabBarController)?.selectedIndex = 0
        case .listJoke:
            (rootViewController as? UITabBarController)?.selectedIndex = 1
        case .sortedJoke:
            (rootViewController as? UITabBarController)?.selectedIndex = 2
        }
    }
    
    func resetToRoot() -> Self {
        loadJokeCoordinator.resetToRoot()
        moveTo(flow: .loadJoke)
        return self
    }
}
