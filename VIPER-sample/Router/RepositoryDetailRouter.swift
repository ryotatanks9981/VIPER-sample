//
//  RepositoryDetailRouter.swift
//  VIPER-sample
//
//  Created by Ryota Karita on 2021/05/14.
//

import Foundation
import UIKit

protocol RepositoryDetailWriteframe: AnyObject {
}

class RepositoryDetailRouter {
    private unowned let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    static func assembleModule(repository: RepositoryEntity) -> UIViewController {
        let view = RepositoryDetailViewController()
        let router = RepositoryDetailRouter(viewController: view)
        let presenter = RepositoryDetailPresenter(view: view, router: router, repository: repository)
        view.presenter = presenter
        
        return view
    }
}

extension RepositoryDetailRouter: RepositoryDetailWriteframe {
    
}
