//
//  CategoriesViewController.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 30.06.2024.
//

import UIKit

class CategoriesViewController: UITableViewController {
    
    //MARK: - Properties
    
    var coordinator: Coordinator?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Without category"
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DownloadManager.shared.jokes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = UIListContentConfiguration.cell()
        config.text = DownloadManager.shared.jokes[indexPath.row].jokeValue
        config.secondaryText = DownloadManager.shared.jokes[indexPath.row].createdAt.formatted()
        cell.contentConfiguration = config
        return cell
    }
}
