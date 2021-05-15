//
//  ArticleListPresenter.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/12.
//

import Foundation

protocol ArticleListPresentation: AnyObject {
    func searchButtonDidPush(searchText: String)
    func didSelect(article: ArticleEntity)
    func pulldown(searchText: String)
}

final class ArticleListPresenter {
    private weak var view: ArticleListView?
    private let router: ArticleListWriteframe
    private let articleListInteractor: ArticleListUsecase
    
    init(view: ArticleListViewController, router: ArticleListWriteframe, articleListInteractor:ArticleListUsecase) {
        self.view = view
        self.router = router
        self.articleListInteractor = articleListInteractor
    }
}

extension ArticleListPresenter: ArticleListPresentation {
    func searchButtonDidPush(searchText: String) {
        fetchArticles(searchText: searchText)
    }
    
    func didSelect(article: ArticleEntity) {
        router.showArticleDetail(article: article)
    }
    
    func pulldown(searchText: String) {
        fetchArticles(searchText: searchText)
    }
    
    private func fetchArticles(searchText: String) {
        guard !searchText.isEmpty else { return }
        articleListInteractor.fetchArticles(keyword: searchText) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.view?.updateArticles(articles)
                break
            case .failure(let error):
                self?.view?.showError(error: error)
                break
            }
        }
    }
}
