//
//  ArticleListPresenter.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/12.
//

import Foundation

protocol SearchRepositoryListPresentation: AnyObject {
    func searchButtonDidPush(searchText: String)
    func didSelect(repository: RepositoryEntity)
    func pulldown(searchText: String)
}

final class SearchRepositoryListPresenter {
    private weak var view: SearchRepositoryListView?
    private let router: SearchRepositoryListWriteframe
    private let articleListInteractor: SearchRepositoryListUsecase
    
    init(view: SerchRepositoryListViewController, router: SearchRepositoryListWriteframe, articleListInteractor:SearchRepositoryListUsecase) {
        self.view = view
        self.router = router
        self.articleListInteractor = articleListInteractor
    }
}

extension SearchRepositoryListPresenter: SearchRepositoryListPresentation {
    func searchButtonDidPush(searchText: String) {
        fetchArticles(searchText: searchText)
    }
    
    func didSelect(repository: RepositoryEntity) {
        router.showRepositoryDetail(repository: repository)
    }
    
    func pulldown(searchText: String) {
        fetchArticles(searchText: searchText)
    }
    
    private func fetchArticles(searchText: String) {
        guard !searchText.isEmpty else { return }
        view?.showLoadView()
        articleListInteractor.fetchRepositories(keyword: searchText) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.view?.dismissLoadView()
                self?.view?.updateArticles(repositories)
                break
            case .failure(let error):
                self?.view?.dismissLoadView()
                self?.view?.showError(error: error)
                break
            }
        }
    }
}
