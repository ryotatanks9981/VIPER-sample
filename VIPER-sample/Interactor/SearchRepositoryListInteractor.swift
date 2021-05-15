//
//  ArticleListInteractor.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/12.
//

import Foundation

protocol SearchRepositoryListUsecase: AnyObject {
    func fetchRepositories(keyword: String, completion: @escaping (Result<[RepositoryEntity], Error>) -> Void)
}

final class SearchRepositoryListInteractor {
    private let client: GithubRequestable
    
    init(client: GithubRequestable = GithubClient()) {
        self.client = client
    }
}

extension SearchRepositoryListInteractor: SearchRepositoryListUsecase {
    func fetchRepositories(keyword: String, completion: @escaping (Result<[RepositoryEntity], Error>) -> Void) {
        let request = GithubAPI.SearchRepository(keyword: keyword)
        client.send(request: request) { result in
            completion(result.map { $0.items })
        }
    }
}
