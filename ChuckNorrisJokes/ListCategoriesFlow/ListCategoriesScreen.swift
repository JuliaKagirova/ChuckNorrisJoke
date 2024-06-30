//
//  JokesCategoriesScreen.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import UIKit
import RealmSwift


/*
 Отображение загруженных цитат группированных по категориям
 
 На этой вкладке должен располагаться список загруженных категорий. При нажатии на категорию должен осуществляться на экран цитат этой категории.
 
 Приложение должно загружать цитату, определять категорию (если такая есть), и соответственно, сохранять цитату и категорию. Так же необходимо учесть ситуацию дублирования цитат и категорий.
 
 
 */

class ListCategoriesScreen: UITableViewController {
    
    //MARK: - Private Properties
    
    var coordinator: Coordinator?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        title = "Sorted Jokes"
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
