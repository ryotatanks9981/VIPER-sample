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
        
        let presenter = ArticleListPresenter(view: view)
        
        return view
    }
    
}

extension ArticleListRouter: ArticleListWriteframe {
    func showArticleDetail(article: ArticleEntity) {
        
    }
}
