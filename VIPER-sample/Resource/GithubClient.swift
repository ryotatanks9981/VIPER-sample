//
//  QiitaClient.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/12.
//

import Foundation

protocol GithubRequestable: AnyObject {
    func send<Request: GithubRequest>(request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void)
}

class GithubClient {
    private let session: URLSession
    
    init(session: URLSession = {
        let conf = URLSessionConfiguration.default
        let session = URLSession(configuration: conf)
        return session
    }()) {
        self.session = session
    }
}

extension GithubClient: GithubRequestable {
    
    func send<Request>(request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) where Request : GithubRequest {
        let urlRequest = request.buildRequest()
        let task = session.dataTask(with: urlRequest) { data, response, error in
            
            switch (data, response, error) {
            case (_, _, let error?):
                print(error.localizedDescription)
                completion(.failure(error))
            case (let data?, let response?, _):
                do {
                    let response = try request.response(from: data, urlResponse: response)
                    completion(.success(response))
                } catch {
                    completion(.failure(NSError()))
                }
            default:
                completion(.failure(NSError()))
            }
        }
        
        task.resume()
    }
    
    
}
