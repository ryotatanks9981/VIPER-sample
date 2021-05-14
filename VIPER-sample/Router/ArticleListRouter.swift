//
//  ArticleListRouter.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/12.
//

import Foundation
import UIKit

protocol ArticleListWriteframe: AnyObject {
    func showArticleDetail(article: ArticleEntity)
}

final class ArticleListRouter {
    
    private unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func assembleModule() -> UIViewController {
        let view = ArticleListViewController()
        let router = ArticleListRouter(viewController: view)
        let articleListInteractor = ArticleListInteractor()
        let presenter = ArticleListPresenter(view: view, router: router, articleListInteractor: articleListInteractor)
        view.presenter = presenter
        return view
    }
    
}

extension ArticleListRouter: ArticleListWriteframe {
    func showArticleDetail(article: ArticleEntity) {
        let viewController = RepositoryDetailRouter.assembleModule(repository: article)
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
