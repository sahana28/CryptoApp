//
//  NetworkManager.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 18/08/24.
//

import Foundation
import Combine

class NetworkManager  {
    
    enum NetworkingError : LocalizedError {
        case badURLResponse(url : URL)
        case unknown
        
        var errorDescription: String? {
            switch(self) {
            case .badURLResponse(url: let url): return "[🔥] bad server response for url \(url)"
            case .unknown: return "unknown error occured"
            }
        }
    }
    
    static func download(from url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
           // .subscribe(on: DispatchQueue.global(qos: .default)) URLSession already downloads data in background so no need to explicitly send on background
            .tryMap({ try handleURLResponse(output:$0, url: url) })
            .retry(3)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output:URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkingError.badURLResponse(url: url) }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch(completion) {
        case .finished:
            break
        case .failure(let error) :
            print(error.localizedDescription)
        }
    }
}
