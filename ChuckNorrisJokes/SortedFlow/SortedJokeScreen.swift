//
//  SortedJokeScreen.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import UIKit

// coreData??

/*
 Отображение загруженных цитат группированных по категориям

 На этой вкладке должен располагаться список загруженных категорий. При нажатии на категорию должен осуществляться на экран цитат этой категории.

 Приложение должно загружать цитату, определять категорию (если такая есть), и соответственно, сохранять цитату и категорию. Так же необходимо учесть ситуацию дублирования цитат и категорий.


 */


class SortedJokeScreen: UITableViewController {

    //MARK: - Private Properties
    
    var coordinator: Coordinator?
    
    private lazy var loadJokeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sort", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        return button
    }()
    
    
    
    //MARK: - Life Cycle

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        title = "Sorted Jokes"
        view.addSubview(loadJokeButton)
        NSLayoutConstraint.activate([
            loadJokeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                constant: 24),
            loadJokeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, 
                                                    constant: 22),
            loadJokeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                    constant: -22),
            loadJokeButton.heightAnchor.constraint(equalToConstant: 50)
            
        
        ])
    }

    //MARK: - Event Handlers
    
    @objc private func buttonTapped() {

    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



//import CoreData
//class JokesTableViewController: UITableViewController {
//    lazy var fetchedResulController: NSFetchedResultsController = {
//        let request = Joke.fetchRequest()
//        request.sortbescriotors = [NSSortDescriotor(key: "downloadDate", ascending: false)]
//        let frc = NSFetchedResultsController(
//            fetchRequest: request,
//            managedObjectContext: CoreDataManager.shared.NSPersistentContainer.viewContext,
//            sectionNameKeyPath: nil,
//            cacheName: nil)
//        return frc
//    }()
//    
//    
//    
//    
//    override func viewDidload() {
//        super.viewDidload()
//        view.backgroundColor = .white
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            image: UIImage(named: "gobackward"),
//            style: .plain,
//            target: self,
//            action: #selector(didTapRefresh))
//    }
//    
//  @objc private func didTapRefresh() {
//      DownloadManager.shared.downloadJoke {
//          switch result {
//          case .success:
//
//          }
//      }
//    }
//    
//}
