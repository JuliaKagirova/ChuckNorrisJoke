//
//  DownloadManager.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import UIKit
import RealmSwift
import Realm

class DownloadManager {
    
    static let shared = DownloadManager()
    
    var jokes: [JokeModel] = []
    var categories: [Category] = []
    
    init() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            deleteRealmIfMigrationNeeded: true
        )
        Realm.Configuration.defaultConfiguration = config
        
        self.jokes = fetchJokes()
        //        self.categories = fetchCategories()
    }
    
    func addJoke(data: JokeDataModel) {
        let realm = try! Realm()
        let joke = JokeModel()
        joke.jokeValue = data.value
        joke.createdAt = Date()
        try! realm.write {
            realm.add(joke)
        }
        jokes = fetchJokes()
    }
    
    func deleteJoke(at index: Int) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(jokes[index])
        }
        jokes = fetchJokes()
    }
    
    func fetchJokes() -> [JokeModel] {
        let realm = try! Realm()
        let joke = JokeModel()
        joke.createdAt = Date()
        return realm.objects(JokeModel.self).map { $0 }
    }
    
    func fetchCategories() -> [JokeModel] {
        let realm = try! Realm()
        return realm.objects(JokeModel.self).map { $0 }
    }
    
    func sortedJokesByDate(isAscending: Bool) -> [JokeModel] {
        try! Realm()
            .objects(JokeModel.self)
            .sorted(byKeyPath: "createdAt", ascending: isAscending)
            .map { $0 }
    }
    
    func sortJokesByDate(isAscending: Bool) {
        jokes = sortedJokesByDate(isAscending: isAscending)
    }
    
    func addCategory(categories: String) {
        let realm = try! Realm()
        let category = Category()
        category.title = categories
        try! realm.write {
            realm.add(category)
        }
    }
}
