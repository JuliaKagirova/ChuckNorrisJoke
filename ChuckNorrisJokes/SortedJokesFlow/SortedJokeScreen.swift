//
//  SortedJokeScreen.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import UIKit
import RealmSwift

//MARK: - Enum

enum State {
    case sorted
    case unsorted
}

class SortedJokeScreen: UITableViewController {
    
    // MARK: - Properties
    
    var coordinator: Coordinator?
    var state = State.unsorted
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("SortedScreen.title", comment: " " )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.up.arrow.down"),
            style: .plain,
            target: self,
            action: #selector(dateFormatterButtonTapped))
    }
    
    //MARK: - Private Method
    
    private func sortArray() {
        DownloadManager.shared.sortJokesByDate(isAscending: false)
        tableView.reloadData()
        print("Joke sorted by date")
    }
    private func desortArray() {
        DownloadManager.shared.sortJokesByDate(isAscending: true)
        tableView.reloadData()
        print("Joke desorted by date")
    }
    
    private func sort() {
        if state == .unsorted {
            sortArray()
            state = .sorted
        } else {
            desortArray()
            state = .unsorted
        }
    }
    
    // MARK: - Event Handler
    
    @objc private func dateFormatterButtonTapped() {
        sort()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        DownloadManager.shared.jokes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = UIListContentConfiguration.cell()
        let sortedJokes = DownloadManager.shared.jokes
        config.text = sortedJokes[indexPath.row].jokeValue
        config.secondaryText = sortedJokes[indexPath.row].createdAt.formatted()
        cell.contentConfiguration = config
        return cell
    }
}
