//
//  LoadTableViewController.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import UIKit
import RealmSwift

class LoadScreen: UITableViewController {
    
    //MARK: - Properties
    
    var coordinator: Coordinator?
    private let networkClient: INetworkClient = NetworkClient()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(didTapAddButton)
        )
    }
    
    //MARK: - Methods
    
    private func setupUI() {
        title = NSLocalizedString("LoadScreen.title", comment: " " )
    }
    
    func buttonTapped(completion: @escaping ((_ value: JokeDataModel?, _ error: String?) -> Void)) {
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else {
            return
        }
        let urlRequest = URLRequest(url: url)
        networkClient.request(with: urlRequest) { result in
            switch result {
            case let .success(data):
                do {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    let joke = try jsonDecoder.decode(JokeDataModel.self, from: data)
                    completion(joke, nil)
                } catch {
                    completion(nil, error.localizedDescription)
                }
            case .failure:
                break
            }
        }
    }
    
    //MARK: - Event Handlers
    
    @objc private func didTapAddButton() {
        buttonTapped { [weak self] joke, error in
            if let joke {
                DispatchQueue.main.async {  [weak self] in
                    DownloadManager.shared.addJoke(data: joke)
                    self?.tableView.reloadData()
                    print("Joke added")
                }
            } else if let error {
                print("error printed: \(error)")
            }
        }
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView,commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DownloadManager.shared.deleteJoke(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            
        }
    }
}

