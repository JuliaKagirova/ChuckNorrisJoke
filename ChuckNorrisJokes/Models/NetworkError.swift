//
//  NetworkError.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import Foundation

enum NetworkError: Error {
    case parsingError
    case noInternet
    case noData
}
