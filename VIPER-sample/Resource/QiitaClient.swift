//
//  QiitaClient.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/12.
//

import Foundation

protocol QiitaRequestable: AnyObject {
    func send<Request: QiitaRequest>(request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void)
}

class QiitaClient {
    private let session: URLSession
    
    init(session: URLSession = {
        let conf = URLSessionConfiguration.default
        let session = URLSession(configuration: conf)
        return session
    }()) {
        self.session = session
    }
}

extension QiitaClient: QiitaRequestable {
    
    func send<Request>(request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) where Request : QiitaRequest {
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
