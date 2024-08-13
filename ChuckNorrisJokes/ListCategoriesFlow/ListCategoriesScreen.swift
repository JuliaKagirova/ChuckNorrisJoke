//
//  ListCategoriesScreen.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import UIKit
import RealmSwift

class ListCategoriesScreen: UITableViewController {
    
    //MARK: - Properties
    
    var coordinator: Coordinator?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        title =  NSLocalizedString("CategoriesScreen.title", comment: "") 
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DownloadManager.shared.categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = UIListContentConfiguration.cell()
        config.text = DownloadManager.shared.categories[indexPath.row]
        cell.contentConfiguration = config
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = DownloadManager.shared.categories[indexPath.row]
        let categoriesViewController = CategoriesViewController()
        navigationController?.pushViewController(categoriesViewController, animated: true)
    }
}
