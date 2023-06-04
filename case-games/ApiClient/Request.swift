//
//  Request.swift
//  case-games
//
//  Created by Eyüp Mert on 2.06.2023.
//

import Foundation

/// Object that represent single api call
final class Request {
    
    /// Api Constants
    private struct Constants {
        static let baseUrl = "https://api.rawg.io/api"
        static let apiKey = "376ea6274e4a43c68c469b95736a271b"
        
    }
    /// Desired Endpoint
    private let endpoint: Endpoint
    
    /// Path components for api, if any
    private let pathComponents: [String]
    
    /// Query arguments for api, if any
    private var queryParameters: [URLQueryItem]
    
    /// Constructed url for the api request in string format
    private var urlString : String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach ( {
                string += "/\($0)"
            })
        }
        
    
        
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else {return nil}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            string += argumentString
        }
        return string
    }
    
    /// Computed & constructed api url
    public var url:URL? {
        return URL(string: urlString)
    }
    
    
    /// Desired http method
    public let httpMethod = "GET"
    
    
    
    // MARK: - Public
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of path components
    ///   - queryParameters: Collection of query parameters
    public init(endpoint: Endpoint,
                pathComponents: [String] = []
                , queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0]
                if let endpoint = Endpoint(rawValue: endpointString) {
                    self.init(endpoint: endpoint)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty {
                let endpointString = components[0]
                let queryItemsString = components[1]
                let queryItems : [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    
                    return URLQueryItem(name: parts[0],
                                        value: parts[1])
                })
                
                if let endpoint = Endpoint(rawValue: endpointString) {
                    self.init(endpoint: endpoint, queryParameters: queryItems)
                    return
                }
            }
        }
        return nil
        
    }
    
    
}



extension Request {
    /// Create first page's request with static parameters.
    static let listGamesRequest = Request(endpoint: .games, queryParameters: [URLQueryItem(name: QueryParameters.key.rawValue, value: Constants.apiKey),
                                                                              URLQueryItem(name: QueryParameters.page_size.rawValue, value: "10"),
                                                                              URLQueryItem(name: QueryParameters.page.rawValue, value: "1")])
}
