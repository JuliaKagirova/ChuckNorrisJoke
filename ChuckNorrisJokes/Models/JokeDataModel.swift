//
//  JokeDataModel.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import Foundation
import RealmSwift

struct JokeDataModel: Codable {
    var value: String
    var categories: [String]
    var createdAt: Date
}

class JokeCodable: Object {
    @Persisted var jokeValue: String = ""
    @Persisted var createdAt: Date = Date()
    @Persisted var categories: List<Category>
}


class Category: Object {
    @Persisted var title: String = ""
}
