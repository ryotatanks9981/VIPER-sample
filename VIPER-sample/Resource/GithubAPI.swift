//
//  QiitaAPI.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/12.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol GithubRequest {
    associatedtype Response: Decodable
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
}

extension GithubRequest {
    var baseURL: URL {
        URL(string: "https://api.github.com")!
    }
    
    func buildRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems
        
        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
    func response(from data: Data, urlResponse: URLResponse) throws -> Response {
        let decoder = JSONDecoder()
        
        if case (200..<300)? = (urlResponse as? HTTPURLResponse)?.statusCode {
            return try decoder.decode(Response.self, from: data)
        } else {
            throw NSError()
        }
    }
}

final class GithubAPI {
    struct SearchRepository: GithubRequest {
        
        typealias Response = SearchResponseEntity<RepositoryEntity>
        
        let keyword: String
        var method: HTTPMethod {
            .get
        }
        
        var path: String {
            return "/search/repositories"
        }
        
        var queryItems: [URLQueryItem] {
            return [URLQueryItem(name: "q", value: keyword)]
        }
    }
}
