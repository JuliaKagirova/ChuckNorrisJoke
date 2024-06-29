//
//  JokeDataModel.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import Foundation
import RealmSwift

struct JokeDataModel: Codable {
    let value: String
    let categories: [String]
}

class JokeModel: Object {
    @Persisted var jokeValue: String = ""
    @Persisted var createdAt: Date = Date()
    @Persisted var categories: List<String> = .init()
}
