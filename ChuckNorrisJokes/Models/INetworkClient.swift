//
//  INetworkClient.swift
//  ChuckNorrisJokes
//
//  Created by Юлия Кагирова on 20.06.2024.
//

import Foundation

protocol INetworkClient {
    func request(with urlRequest: URLRequest, completion: @escaping(Result<Data, NetworkError>) -> Void)
}

final class NetworkClient: INetworkClient {
    
    static let shared = NetworkClient()
    
    func request(with urlRequest: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(.parsingError))
                    print(error.localizedDescription)
                }
            }
            guard let data else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }
}
