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
    var categories: [String] = []
    
    init() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            deleteRealmIfMigrationNeeded: false
        )
        Realm.Configuration.defaultConfiguration = config
        
        self.jokes = fetchJokes()
        self.categories = fetchCategories()
    }
    
    func addJoke(data: JokeDataModel) {
        let realm = try! Realm()
        let joke = JokeModel()
        joke.jokeValue = data.value
        joke.createdAt = Date()
        if data.categories.isEmpty {
            joke.categories.append("Без категории")
        } else {
            joke.categories.append(objectsIn: data.categories)
        }
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

    func fetchCategories() -> [String] {
        let categories = try! Realm().objects(JokeModel.self).flatMap({ $0.categories }).map { $0 }
        return Array(Set(categories))
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
}
