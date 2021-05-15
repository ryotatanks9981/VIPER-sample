//
//  ArticleListRouter.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/12.
//

import Foundation
import UIKit

protocol SearchRepositoryListWriteframe: AnyObject {
    func showRepositoryDetail(repository: RepositoryEntity)
}

final class SearchRepositoryListRouter {
    
    private unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func assembleModule() -> UIViewController {
        let view = SerchRepositoryListViewController()
        let router = SearchRepositoryListRouter(viewController: view)
        let articleListInteractor = SearchRepositoryListInteractor()
        let presenter = SearchRepositoryListPresenter(view: view, router: router, articleListInteractor: articleListInteractor)
        view.presenter = presenter
        return view
    }
    
}

extension SearchRepositoryListRouter: SearchRepositoryListWriteframe {
    func showRepositoryDetail(repository: RepositoryEntity) {
        let viewController = RepositoryDetailRouter.assembleModule(repository: repository)
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
