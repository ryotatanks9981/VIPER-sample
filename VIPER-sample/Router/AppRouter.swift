//
//  AppRouter.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/11.
//

import Foundation
import UIKit

protocol AppWriteframe: AnyObject {
    func showArticleListView()
}

final class AppRouter {
    private let window: UIWindow
    
    private init(window: UIWindow) {
        self.window = window
    }
    
    static func assembleModule(window: UIWindow) -> AppPresentation {
        let router = AppRouter(window: window)
        let presenter = AppPresenter(router: router)
        return presenter
    }
}

extension AppRouter: AppWriteframe {
    func showArticleListView() {
        let articleListViewController = ArticleListRouter.assembleModule()
        let navVC = UINavigationController(rootViewController: articleListViewController)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
    }
}
