//
//  BaseCoordinator.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import UIKit

typealias Action = (() -> Void)

protocol FlowCoordinator: AnyObject {
    var parentCoordinator: MainBaseCoordinator? { get set }
}

protocol Coordinator: FlowCoordinator {
    var rootViewController: UIViewController { get set }
    func start() -> UIViewController
    @discardableResult func resetToRoot() -> Self
}

extension Coordinator {
    var navigationRootViewController: UINavigationController? {
        get {
            (rootViewController as? UINavigationController)
        }
    }
    
    func resetToRoot() -> Self {
        navigationRootViewController?.popToRootViewController(animated: false)
        return self
    }
}
// MARK: - Tabbar Protocol

protocol LoadedJokeBaseCoordinator: Coordinator {
    func showLoadedJokeScreen()
}

protocol SortedJokeBaseCoordinator: Coordinator {
    func showSortedJokeScreen()
}

protocol ListCategoriesBaseCoordinator: Coordinator {
    func showJokeSortedByCategoryScreen()
}

protocol MapBaseCoordinator: Coordinator {
    func showMapScreen()
}

protocol SettingsBaseCoordinator: Coordinator {
    func showSettings()
}

protocol MainBaseCoordinator: Coordinator {
    var loadedJokeCoordinator: LoadedJokeBaseCoordinator { get }
    var sortedJokeCoordinator: SortedJokeBaseCoordinator { get }
    var listCategoriesCoordinator: ListCategoriesBaseCoordinator { get }
    var mapCoordinator: MapBaseCoordinator { get }
    var settingsCoordinator: SettingsBaseCoordinator { get }
    func moveTo(flow: AppFlow)
}


