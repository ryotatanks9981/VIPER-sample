//
//  ArticleListInteractor.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/12.
//

import Foundation

protocol ArticleListUsecase: AnyObject {
    func fetchArticles(keyword: String, completion: @escaping (Result<[ArticleEntity], Error>) -> Void)
}

final class ArticleListInteractor {
    private let client: String
    
    init(client: String = "") {
        self.client = client
    }
}

extension ArticleListInteractor: ArticleListUsecase {
    func fetchArticles(keyword: String, completion: @escaping (Result<[ArticleEntity], Error>) -> Void) {
//        let request = 
    }
}
