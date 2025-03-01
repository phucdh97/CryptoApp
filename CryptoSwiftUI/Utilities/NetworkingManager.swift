//
//  NetworkingManager.swift
//  CryptoSwiftUI
//
//  Created by Do Huu Phuc on 15/4/25.
//

import Foundation
import Combine

class NetworkingManager {
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .failure(let error):
            print("Failed to fetch: \(error.localizedDescription)")
        case .finished:
            break
        }
    }
}
