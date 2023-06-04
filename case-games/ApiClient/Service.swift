//
//  Service.swift
//  case-games
//
//  Created by Eyüp Mert on 2.06.2023.
//

import Foundation

/// Primary api service object to get data
final class Service {
    
    /// Shared singleton instance
    static let shared = Service()
    
    /// Privatized constructor.
    private init() {}
    
    enum ServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// Send APi Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: Expected type from request
    ///   - completion: Callback with data or error
    public func execute<T: Codable> (
        _ request: Request,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        print("URLRequest: \(urlRequest)")

        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.failedToGetData))
                return
            }
            // Decode response
            do {

                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))

                print(String(describing: result))
            } catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
        
        
    }
    
    // MARK: - Private
    
    private func request(from request: Request) -> URLRequest? {
        guard let url = request.url else {return nil}
        var request = URLRequest(url: url)
        request.httpMethod = request.httpMethod
        return request
    }
    
    
}
