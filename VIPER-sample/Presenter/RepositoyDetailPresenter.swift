//
//  RepositoyDetailPresenter.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/14.
//

import Foundation

protocol RepositoryDetailPresentation: AnyObject {
    func viewDidLoad()
}

class RepositoryDetailPresenter {
    private weak var view: RepositoryDetailView?
    private let router: RepositoryDetailWriteframe
    private let repository: RepositoryEntity
    
    init(view: RepositoryDetailView, router: RepositoryDetailWriteframe, repository: RepositoryEntity) {
        self.view = view
        self.router = router
        self.repository = repository
    }
}

extension RepositoryDetailPresenter: RepositoryDetailPresentation {
    func viewDidLoad() {
        view?.load(request: URLRequest(url: repository.htmlURL))
    }
}
