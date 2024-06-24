//
//  LoadTableViewController.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import UIKit
import RealmSwift

class LoadScreen: UITableViewController {
    
    //MARK: - Private Properties
    
    var jokes: [Joke] = []
    var coordinator: Coordinator?
    private var downloadManager = DownloadManager()
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
    
    //MARK: - Private Methods
    
    private func setupUI() {
        title = "Load"
    }
    
     func buttonTapped(completion: @escaping ((_ value: String?, _ error: String?) -> Void)) {
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else
        { return }
        let urlRequest = URLRequest(url: url)
        networkClient.request(with: urlRequest) { [weak self ] result in
            guard let self else { return }
            switch result {
            case let .success(data):
                do {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
                    
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    let answer = try jsonDecoder.decode(Joke.self, from: data)
                    let value = answer.value
                    completion(value, nil)
                    jokes.append(answer)
                } catch {
                    completion(nil, error.localizedDescription)
                    print("error: \(error.localizedDescription)")
                }
            case .failure:
                break
            }
        }
    }
    
    //MARK: - Event Handlers
    
    
    @objc private func didTapAddButton() {
        buttonTapped { [ weak self ] title, error in
            if let title {
                DispatchQueue.main.async {  [ weak self ] in
                    self!.downloadManager.addJoke(value: title)
                    self!.tableView.reloadData()
                }
            } else if let error {
                print("error printed: \(error)")
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        downloadManager.jokes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var config = UIListContentConfiguration.cell()
        config.text = downloadManager.jokes[indexPath.row].jokeValue
        config.secondaryText = downloadManager.jokes[indexPath.row].createdAt.formatted()
        cell.contentConfiguration = config
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView,commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            downloadManager.deleteJoke(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            
        }
    }
    //            override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let joke = downloadManager.jokes[indexPath.row]
    //        let itemsManager = ItemsManager(folder: folder)
    //        let itemsViewController = ItemsViewController(itemsManager: itemsManager)
    //        navigationController?.pushViewController(itemsViewController, animated: true)
    //    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
}

