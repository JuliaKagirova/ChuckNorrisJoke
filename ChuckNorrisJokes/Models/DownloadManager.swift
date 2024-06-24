//
//  DownloadManager.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import UIKit
import RealmSwift

class DownloadManager {
    
    static let shared = DownloadManager()
    
    var jokes: [JokeCodable] = []
    
    init() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            deleteRealmIfMigrationNeeded: true
        )
        Realm.Configuration.defaultConfiguration = config
        
        self.jokes = fetchJokes()
    }
    
    func addJoke(value: String) {
        let realm = try! Realm()
        let joke = JokeCodable()
        joke.jokeValue = value
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
    
    func fetchJokes() -> [JokeCodable] {
        let realm = try! Realm()
        return realm.objects(JokeCodable.self).map { $0 }
    }
    
    func sortByDate() {
        let realm = try! Realm()
        let allJokes = realm.objects(JokeCodable.self)
//        let sortByDate = realm.objects(JokeCodable.self).filter(<#T##predicate: Predicate<JokeCodable>##Predicate<JokeCodable>#>)
        let sortByDate = realm.objects(JokeCodable.self).sorted(byKeyPath: "createdAt")
        jokes = fetchJokes()
        
    }
    func jokeSortedByDate() {
        let realm = try! Realm()
        var sortedJokeByDate = realm.objects(JokeCodable.self).sorted(byKeyPath: "createdAt", ascending: true)
    }

}
 
