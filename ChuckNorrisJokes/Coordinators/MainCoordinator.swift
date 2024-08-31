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
    case map
    case settings
}

class MainCoordinator: MainBaseCoordinator {
    
    var parentCoordinator: MainBaseCoordinator?
    
    lazy var loadedJokeCoordinator: LoadedJokeBaseCoordinator = LoadedJokeCoordinator()
    
    lazy var sortedJokeCoordinator: SortedJokeBaseCoordinator = SortedJokeCoordinator()
    
    lazy var listCategoriesCoordinator: ListCategoriesBaseCoordinator = ListCategoriesCoordinator()
    
    lazy var mapCoordinator: MapBaseCoordinator = MapCoordinator()
    
    lazy var settingsCoordinator: SettingsBaseCoordinator = SettingsCoordinator()
    
    lazy var rootViewController: UIViewController = UITabBarController()
    
    func start() -> UIViewController {
        let loadedJokeViewController = loadedJokeCoordinator.start()
//        loadedJokeViewController.view.backgroundColor = .white
        loadedJokeCoordinator.parentCoordinator = self
        loadedJokeViewController.tabBarItem = UITabBarItem(
            title: "LoadScreen.title".localized,
            image: UIImage(systemName: "square.and.arrow.down"),
            tag: 0
        )
        
        let sortedtJokeViewController = sortedJokeCoordinator.start()
//        sortedtJokeViewController.view.backgroundColor = .white
        sortedJokeCoordinator.parentCoordinator = self
        sortedtJokeViewController.tabBarItem = UITabBarItem(
            title: "SortedScreen.title".localized,
            image: UIImage(systemName: "wand.and.stars.inverse"),
            tag: 1
        )
        
        let listCategoriesViewController = listCategoriesCoordinator.start()
//        listCategoriesViewController.view.backgroundColor = .white
        listCategoriesCoordinator.parentCoordinator = self
        listCategoriesViewController.tabBarItem = UITabBarItem(
            title: "CategoriesScreen.title".localized,
            image: UIImage(systemName: "list.star"),
            tag: 2
        )
        
        let mapViewController = mapCoordinator.start()
//        mapViewController.view.backgroundColor = .white
        mapCoordinator.parentCoordinator = self
        mapViewController.tabBarItem = UITabBarItem(
            title: "MapScreen.title".localized,
            image: UIImage(systemName: "map"),
            tag: 3
        )
        
        let settingsVC = settingsCoordinator.start()
        settingsCoordinator.parentCoordinator = self
        settingsVC.tabBarItem = UITabBarItem(
            title: "Settings.title".localized,
            image: UIImage(systemName: "gear.badge.checkmark"),
            tag: 4
        )
        
        (rootViewController as? UITabBarController)?.viewControllers = [
            loadedJokeViewController,
            sortedtJokeViewController,
            listCategoriesViewController,
            mapViewController,
            settingsVC
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
        case .map:
            (rootViewController as? UITabBarController)?.selectedIndex = 3
        case .settings:
            (rootViewController as? UITabBarController)?.selectedIndex = 4
        }
    }
    
    func resetToRoot() -> Self {
        loadedJokeCoordinator.resetToRoot()
        moveTo(flow: .loadedJoke)
        return self
    }
}
